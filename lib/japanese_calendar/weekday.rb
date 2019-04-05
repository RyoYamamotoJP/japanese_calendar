# frozen_string_literal: true

require 'japanese_calendar/weekday/calculations'
require 'japanese_calendar/weekday/deprecator'

module JapaneseCalendar
  # Weekday extensions to <tt>Date</tt>, <tt>DateTime</tt> and <tt>Time</tt>.
  module Weekday
    prepend Weekday::Deprecator
    include Weekday::Calculations

    # Formats the day of the week according to the directives in the given
    # format string.
    #
    # Format directives:
    #   %JA - The full weekday name in Japanese ("日曜日")
    #   %Ja - The abbreviated weekday name in Japanese ("日")
    #
    # Examples:
    #   date_of_birth = Time.new(1978, 7, 19)
    #
    #   date_of_birth.strftime("%JA")  # => "水曜日"
    #   date_of_birth.strftime("%Ja")  # => "水"
    #
    #   date_of_birth.strftime("%-Y年%-m月%-d日(%Ja)") # => "1978年7月19日(水)"
    def strftime(format)
      string = format.gsub(weekday_pattern, weekday_conversion)
      super(string)
    end

    private

    # Returns a hash representing the format directives of the day of the week.
    def weekday_conversion
      {
        '%JA' => weekday_name,
        '%Ja' => weekday_abbreviation,
        '%Q' => weekday_name,
        '%q' => weekday_abbreviation
      }
    end

    # Returns a Regexp object representing the format directives of
    # the day of the week (/%JA|%Ja|%Q|%q/).
    def weekday_pattern
      Regexp.union(weekday_conversion.keys)
    end
  end
end
