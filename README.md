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


## Config

`Mongoid::Serializer.configure!`

## Usage

```ruby
class UserSerializer < ActiveModel::MongoidSerializer
  attributes :id, :first_name, :last_name, :quote, :age, http_status
end
```

Additionally this gem includes a `ActiveModel::StateTracking` module. This modules provides the methods `created?` and `deleted?` for use with any Mongoid Document.

You can either include this module in models of your choice, or include it into `Mongoid::Document` to make it part of every model. 

`ActiveModel::StatusSerializer` is configured to try to hook into the `StateTracking` methods from [active_model-shaz](https://github.com/kristianmandrup/active_model-shaz) and set the JSON `http_status` key to either `201` or `204`, to reflect created or deleted state back to the client.

`ActiveModel::MongoidSerializer` extends `ActiveModel::StatusSerializer` and sets the `id` attribute to point to `_id` to better work with what the usual client side APIs expect (f.ex for use with ember-data).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
