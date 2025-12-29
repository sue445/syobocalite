# Syobocalite

Lite client for [Syoboi calendar](http://cal.syoboi.jp/) API.

[![Gem Version](https://badge.fury.io/rb/syobocalite.svg)](https://badge.fury.io/rb/syobocalite)
[![test](https://github.com/sue445/syobocalite/actions/workflows/test.yml/badge.svg)](https://github.com/sue445/syobocalite/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/sue445/syobocalite/badge.svg?branch=master)](https://coveralls.io/github/sue445/syobocalite?branch=master)
[![Maintainability](https://qlty.sh/gh/sue445/projects/syobocalite/maintainability.svg)](https://qlty.sh/gh/sue445/projects/syobocalite)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'syobocalite'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install syobocalite

## Usage

```ruby
require "syobocalite"
require "time"

start_at = Time.parse("2018-10-07 08:30:00")
end_at   = Time.parse("2018-10-07 09:00:00")

# or

Time.zone = "Tokyo"
start_at = Time.zone.parse("2018-10-07 08:30:00")
end_at   = Time.zone.parse("2018-10-07 09:00:00")

# Get programs that start between 8:30 and 9:00
Syobocalite.search(start_at: start_at, end_at: end_at)
```

`Syobocalite.search` returns `Array` of [Syobocalite::Program](lib/syobocalite/program.rb)

## vs. [syobocal](https://github.com/xmisao/syobocal)
* Supports only `https://cal.syoboi.jp/cal_chk.php`
* Supports `Time` and [ActiveSupport::TimeWithZone](https://api.rubyonrails.org/classes/ActiveSupport/TimeWithZone.html)
* Returns array of PORO (NOT array of `Hash`)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/syobocalite.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
