#encoding: utf-8

##
## rabbit_consumer.rb
## Gaetan JUVIN 27/07/2015
##

require 'singleton_from'
require 'bunny'

module Rabbitmq
  class Receiver
    class RabbitConsumer
      singleton_from :start

      attr_accessor :action, :options
      attr_accessor :_state
      attr_accessor :rmq_connection, :rmq_channel, :rmq_queue

      def start(options, action)
        @options  = options
        @action   = action

        @_state    = :initialized
        self.print
        self.run
      end

      def state
        @_state.to_s.capitalize
      end

      def print
        if @options[:verbose]
          @options[:logger].info "------- Consumer #{self.__id__} on #{@options[:host]}:#{@options[:port]} -- #{self.state.upcase}".white
        end
      end

      def connect
        @_state         = :connecting
        self.print
        sleep_duration      = 10
        loop do
          begin
            @rmq_connection = Bunny.new(host:     @options[:host],
                                        port:     @options[:port],
                                        vhost:    @options[:vhost],
                                        user:     @options[:user],
                                        password: @options[:password],
                                        heartbeat: 5)
            @rmq_connection.start

            @rmq_channel    = @rmq_connection.create_channel
            @rmq_channel.prefetch(@options[:prefetch])
            @rmq_queue      = @rmq_channel.queue(@options[:queue], durable: @options[:durable], auto_delete: @options[:auto_delete], exlusive: @options[:exclusive])
          rescue Exception => error
            @options[:logger].error "Error: #{error.message}".red
            sleep(sleep_duration)
          else
            @_state         = :connected
            break
          end
          sleep_duration = [300, sleep_duration + 20].max
        end
      end

      def run
        self.connect
        self.print
        if @_state == :connected
          @rmq_queue.subscribe(manual_ack: true, block: true) do |delivery_info, properties, body|
            @options[:logger].info "Receive package.".light_yellow if @options[:verbose]
            next unless delivery_info
            begin
              @action.call(body, delivery_info, properties, self)
              @rmq_channel.ack(delivery_info.delivery_tag)
            rescue RejectPackage => error
              @options[:logger].debug "Exception RejectPackage".yellow
              @rmq_channel.reject(delivery_info.delivery_tag, true)
            rescue Bunny::ChannelAlreadyClosed => error
              @options[:logger].error "Exception ChannelAlreadyClosed".red
              raise error if error.class == Bunny::ChannelAlreadyClosed
            rescue LocalJumpError
              Rabbitmq::Receiver.instance.running = false
              @rmq_channel.ack(delivery_info.delivery_tag)
              @rmq_channel.consumers[delivery_info.consumer_tag].cancel
            rescue Exception => error
              @options[:logger].error "Error: #{error.class} #{error.message}"
              @options[:logger].error error.backtrace.join("\n")
              @rmq_channel.reject(delivery_info.delivery_tag, true)
            end
          end
        end
      end
    end
  end
end
