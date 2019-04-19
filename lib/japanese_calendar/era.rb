# frozen_string_literal: true

require 'japanese_calendar/deprecation/era_wrapper'
require 'japanese_calendar/era/calculations'
require 'japanese_calendar/era/reflection'

module JapaneseCalendar
  # Era extensions to <tt>Date</tt>, <tt>DateTime</tt> and
  # <tt>Time</tt>.
  module Era
    include Era::Calculations
    include Era::Reflection
    prepend Deprecation::EraWrapper

    # Formats the year of the Japanese era according to the directives in the
    # given format string.
    #
    # Format directives:
    #   %JN - The full Japanese era name in Kanji ("令和")
    #   %Jn - The abbreviated Japanese era name in Kanji ("令")
    #   %JR - The full Japanese era name in Romaji ("Reiwa")
    #           %^JR  uppercased ("REIWA")
    #   %Jr - The abbreviated Japanese era name in Romaji ("R")
    #   %Jy - year of the Japanese era, zero-padded (01)
    #           %_Jy  blank-padded ( 1)
    #           %-Jy  no-padded (1)
    #
    # Examples:
    #   date_of_birth = Time.new(1978, 7, 19)
    #
    #   date_of_birth.strftime("%JN")  # => "昭和"
    #   date_of_birth.strftime("%Jn")  # => "昭"
    #   date_of_birth.strftime("%JR")  # => "Showa"
    #   date_of_birth.strftime("%^JR") # => "SHOWA"
    #   date_of_birth.strftime("%Jr")  # => "S"
    #   date_of_birth.strftime("%Jy")  # => "53"
    #
    #   date_of_birth.strftime("%JN%-Jy年")  # => "昭和53年"
    #
    # Raises an error when the Japanese year cannot be found.
    #
    #   Time.new(1872, 12, 31).strftime("%JN%-Jy年") # => RuntimeError
    def strftime(format)
      string = super(format)
      string.gsub(era_pattern, era_conversion)
    end

    private

    # Returns a hash representing the format directives of the Japanese era.
    def era_conversion
      {
        '%JN' => japanese_era_kanji_name,
        '%Jn' => japanese_era_kanji_abbreviated_name,
        '%JR' => japanese_era_romaji_name,
        '%^JR' => japanese_era_romaji_uppercased_name,
        '%Jr' => japanese_era_romaji_abbreviated_name,
        '%Jy' => japanese_era_year_zero_padded_string,
        '%-Jy' => japanese_era_year_string,
        '%_Jy' => japanese_era_year_blank_padded_string
      }
    end

    # Returns a Regexp object representing the format directives of
    # the day of the week
    # (/%JN|%Jn|%JR|%^JR|%Jr|%Jy|%-Jy|%_Jy/).
    def era_pattern
      Regexp.union(era_conversion.keys)
    end
  end
end
