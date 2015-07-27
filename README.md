# Rabbitmq::Receiver

Rabbitmq ruby receiver

## Usage

```ruby
require 'rabbitmq/receiver'

Rabbitmq::Receiver.config do |config|
      config.host 	  = '8.8.8.8'
      config.user 	  = 'superuser'
      config.password = 'superpassword'
      config.vhost    = 'supervhost'
      config.verbose  = true
end

Rabbitmq::Receiver.start do |package|
	package = Package.unpack(package)
end
```

## Configuration - defaults
```
logger:     Logger.new(STDOUT)
host:       '8.8.8.8'
port:       5672
user:       nil
password:   nil
queue:      nil
vhost:      '/'
verbose:    false
prefetch:   100
heartbeat:  5

```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rabbitmq-receiver'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rabbitmq-receiver

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rabbitmq-receiver. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

