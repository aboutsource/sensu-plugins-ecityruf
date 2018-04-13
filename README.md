# Sensu::Plugins::Ecityruf

[![Build Status](https://travis-ci.org/aboutsource/sensu-plugins-ecityruf.svg?branch=master)](https://travis-ci.org/aboutsource/sensu-plugins-ecityruf)

Sensu Handler to send messages to pagers using eCityruf with a `Sammelrufnummer`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sensu-plugins-ecityruf'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sensu-plugins-ecityruf

## Usage

```
{
  "ecityruf": {
    "number": <ECITYRUF NUMBER>,
    "language": "de",
    "url": "https://inetgateway.emessage.de/cgi-bin/funkruf2.cgi"
  }
}
```
`language` and `url`  are optional. See default values in the example above.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
