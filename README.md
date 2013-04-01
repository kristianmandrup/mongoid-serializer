# Mongoid::Serializer

Configure Mongoid with Serialization support in Rails Controllers. 
Will add `id` as an available attribute, which can be used as the primary key as is expected by most API clients.

Inspired by the discussion here: http://stackoverflow.com/questions/11571777/ember-data-and-mongodb-how-to-handle-id

Note: Should work for Mongoid 3+

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid-serializer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-serializer

## Usage

```ruby
class UserSerializer < MongoidSerializer
  attributes :id, :first_name, :last_name, :quote, :age
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
