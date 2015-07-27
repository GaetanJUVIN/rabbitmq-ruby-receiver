#encoding: utf-8

##
## config.rb
## Gaetan JUVIN 27/07/2015
##

require 'gconfig'

module Rabbitmq
  class Receiver
    extend GConfig

    default logger:     Logger.new(STDOUT)
    default host:       '8.8.8.8'
    default port:       5672
    default user:       nil
    default password:   nil
    default queue:      nil
    default vhost:      '/'
    default verbose:    false
    default prefetch:   100
    default heartbeat:  5
    default heartbeat:  5
  end
end
