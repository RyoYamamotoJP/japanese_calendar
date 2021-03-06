# Japanese Calendar [![Gem Version](https://badge.fury.io/rb/japanese_calendar.svg)](https://badge.fury.io/rb/japanese_calendar) [![Build Status](https://travis-ci.org/RyoYamamotoJP/japanese_calendar.svg?branch=master)](https://travis-ci.org/RyoYamamotoJP/japanese_calendar) [![Maintainability](https://api.codeclimate.com/v1/badges/661b3d2765caae7906c6/maintainability)](https://codeclimate.com/github/RyoYamamotoJP/japanese_calendar/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/661b3d2765caae7906c6/test_coverage)](https://codeclimate.com/github/RyoYamamotoJP/japanese_calendar/test_coverage)

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

To get the Japanese era name, use the `era_name` method:

```
Time.new(2019,  5,  1).era_name # => "令和"
Time.new(1989,  1,  8).era_name # => "平成"
Time.new(1926, 12, 25).era_name # => "昭和"
Time.new(1912,  7, 30).era_name # => "大正"
Time.new(1873,  1,  1).era_name # => "明治"
```

If you want to get the Japanese era name in romaji, pass `:romaji`:

```
Time.new(2019,  5,  1).era_name(:romaji) # => "Reiwa"
Time.new(1989,  1,  8).era_name(:romaji) # => "Heisei"
Time.new(1926, 12, 25).era_name(:romaji) # => "Showa"
Time.new(1912,  7, 30).era_name(:romaji) # => "Taisho"
Time.new(1873,  1,  1).era_name(:romaji) # => "Meiji"
```

The following examples show how to check the Japanese era:

```
Time.new(2019,  5,  1).reiwa?  # => true
Time.new(1989,  1,  8).heisei? # => true
Time.new(1926, 12, 25).showa?  # => true
Time.new(1912,  7, 30).taisho? # => true
Time.new(1873,  1,  1).meiji?  # => true
```

You can convert to a Japanese year with the `era_year` method:

```
Time.new(2019,  5,  1).era_year # => 1
Time.new(2019,  4, 30).era_year # => 31
Time.new(1989,  1,  7).era_year # => 64
Time.new(1926, 12, 24).era_year # => 15
Time.new(1912,  7, 29).era_year # => 45
```

To get a string representation of the Japanese calendar, use the `strftime` method:

```
time = Time.new(2019, 5, 1)

# Japanese era
time.strftime("%JN")  # => "令和"
time.strftime("%Jn")  # => "令"
time.strftime("%JR")  # => "Reiwa"
time.strftime("%^JR") # => "REIWA"
time.strftime("%Jr")  # => "R"
time.strftime("%Jy")  # => "01"
time.strftime("%-Jy") # => "1"
time.strftime("%_Jy") # => " 1"

# Japanese weekday name
time.strftime("%JA") # => "水曜日"
time.strftime("%Ja") # => "水"

# More examples
time.strftime("%JN%-Jy年%-m月%-d日(%Ja)") # => "令和1年5月1日(水)"
time.strftime("%Jr%Jy.%m.%d")            # => "R01.05.01"
time.strftime("%B %-d, %-Y (%JR %-Jy)")  # => "May 1, 2019 (Reiwa 1)"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RyoYamamotoJP/japanese_calendar. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
