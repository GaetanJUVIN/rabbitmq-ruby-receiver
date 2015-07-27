#encoding: utf-8

##
## receiver.rb
## Gaetan JUVIN 27/07/2015
##

require 'rabbitmq/receiver/config'
require 'rabbitmq/receiver/exception'
require 'rabbitmq/receiver/rabbit_consumer'
require 'rabbitmq/receiver/receiver'
require 'rabbitmq/receiver/version'

require 'singleton_from'

module Rabbitmq
  class Receiver
    singleton_from :start
  end
end
