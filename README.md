# Japanese Calendar [![Gem Version](https://badge.fury.io/rb/japanese_calendar.svg)](https://badge.fury.io/rb/japanese_calendar) [![Build Status](https://travis-ci.org/RyoYamamotoJP/japanese_calendar.svg?branch=master)](https://travis-ci.org/RyoYamamotoJP/japanese_calendar) [![Code Climate](https://codeclimate.com/github/RyoYamamotoJP/japanese_calendar/badges/gpa.svg)](https://codeclimate.com/github/RyoYamamotoJP/japanese_calendar) [![Test Coverage](https://codeclimate.com/github/RyoYamamotoJP/japanese_calendar/badges/coverage.svg)](https://codeclimate.com/github/RyoYamamotoJP/japanese_calendar/coverage)

Japanese calendar utility for Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'japanese_calendar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install japanese_calendar

## Usage

To get a Japanese era name, use the `era_name` method:

```
Time.new(1989,  1,  8).era_name # => "平成"
Time.new(1926, 12, 25).era_name # => "昭和"
Time.new(1912,  7, 30).era_name # => "大正"
Time.new(1873,  1,  1).era_name # => "明治"
```

You can convert to a Japanese year with the `era_year` method:

```
Time.new(2016, 12, 11).era_year # => 28
Time.new(1989,  1,  7).era_year # => 64
Time.new(1926, 12, 24).era_year # => 15
Time.new(1912,  7, 29).era_year # => 45
```

To get a string representation of the Japanese era, use the `strftime` method:

```
time = Time.new(1989, 1, 1)
time.strftime("%K")               # => "平成"
time.strftime("%O")               # => "Heisei"
time.strftime("%^O")              # => "HEISEI"
time.strftime("%o")               # => "H"
time.strftime("%J")               # => "01"
time.strftime("%-J")              # => "1"
time.strftime("%_J")              # => " 1"
time.strftime("%K%-J年%-m月%-d日") # => "平成1年1月1日"
time.strftime("%o%J.%m.%d")       # => H01.01.01
time.strftime("%b %-d %O %-J")    # => Jan 1 Heisei 1
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RyoYamamotoJP/japanese_calendar. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
