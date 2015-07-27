#encoding: utf-8

##
## rabbitmq-receiver.gemspec
## Gaetan JUVIN 27/07/2015
##

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rabbitmq/receiver/version'

Gem::Specification.new do |spec|
  spec.name          = "rabbitmq-receiver"
  spec.version       = Rabbitmq::Receiver::VERSION
  spec.authors       = ["Gaëtan JUVIN"]
  spec.email         = ["gaetanjuvin@gmail.com"]

  spec.summary       = %q{Rabbitmq ruby receiver}
  spec.homepage      = 'https://github.com/GaetanJUVIN/rabbitmq-ruby-sender'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_dependency 'bunny', '~> 0'
  spec.add_dependency 'gconfig', '~> 0'
  spec.add_dependency 'singleton_from', '~> 0'
end
