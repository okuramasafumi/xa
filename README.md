# Xa

Xa is eXecutable Annotation in Ruby. We can write some annotations in nearly-natural-language and Xa automatically checks it in load time, allowing us to find mistakes much more quickly.

## Motivation

We write comments. We write comments that aren't maintained or that are just ignored. That's a pity. What if there is a comment that cannot be ignored so that it's maintained along with the code? In other words, what if we have comments that are executable?

Also, types. Everyone talks about types. Ruby is infamous for being dynamically typed. I thought, "how could we bring some benefits of types without adding real types?" and noticed that some portion of that benefits is compile-time error check.

And we CAN do that in Ruby. Although we don't have a clear compile phase in Ruby, class macros are evaluated when the class is loaded, so we can do some check in class macros.

So, "Executable comments in shape of class macros" was what I finally came up with. With that, we can add some annotation, and when it's wrong, it stops execution of the rest of the code so that it's safe.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xa'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install xa

## Usage

Use `xa` block to write annotations in natural language.

```ruby
class Parent
  xa { subclasses must implement m1 }
end

class Child < Parent
end
# => Error because Child doesn't implement m1

class Correct < Parent
  def m1; end
end
# => This is OK
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/okuramasafumi/xa. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/okuramasafumi/xa/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Xa project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/okuramasafumi/xa/blob/main/CODE_OF_CONDUCT.md).
