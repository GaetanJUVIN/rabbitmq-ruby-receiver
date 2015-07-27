#encoding: utf-8

##
## receiver.rb
## Gaetan JUVIN 27/07/2015
##

require 'gconfig'

module Rabbitmq
  class Receiver
    attr_accessor :running, :options, :action

    def run
      @running = true

      while @running
        begin
          @options[:logger].info "New instance" if @options[:verbose]
          rabbit_consumer = RabbitConsumer.start(@options, @action)
          @options[:logger].info "Instance finish" if @options[:verbose]
        rescue Exception => error
          @options[:logger].error "Error: " + error.message
          @options[:logger].error error.backtrace
        end
        sleep 30
      end
    end

    def start(options = {}, &block)
      @options = Rabbitmq::Receiver.config.to_hash.merge(options)
      @running = false
      @action  = block

      @options[:logger].info "------- Runner on #{@options[:host]} starting.".white

      self.run
    end
  end
end
