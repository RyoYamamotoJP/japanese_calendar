# frozen_string_literal: true

module JapaneseCalendar
  module Weekday
    include Deprecator

    # Formats time according to the directives in the given format string.
    #
    #   date_of_birth = Time.new(1978, 7, 19)
    #
    #   date_of_birth.strftime("%JA")  # => "水曜日"
    #   date_of_birth.strftime("%Ja")  # => "水"
    #
    #   date_of_birth.strftime("%-Y年%-m月%-d日(%Ja)") # => "1978年7月19日(水)"
    def strftime(format)
      deprecated_directives = format.scan(DEPRECATION_PATTERN).uniq
      deprecated_directives.each do |key|
        deprecate(key, DEPRECATION_MESSAGES[key])
      end

      string = format.gsub(weekday_pattern, weekday_conversion)
      super(string)
    end

    private

      DEPRECATION_MESSAGES = {
        '%Q' => 'Please use %JA instead.',
        '%q' => 'Please use %Ja instead.'
      }.freeze

      DEPRECATION_PATTERN = Regexp.union(DEPRECATION_MESSAGES.keys)

      def weekday_name
        @weekday_name ||= %w(日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日)[wday]
      end

      def weekday_abbreviation
        @weekday_abbreviation ||= weekday_name[0]
      end

      def weekday_conversion
        @weekday_conversion ||= {
          '%JA' => weekday_name,
          '%Ja' => weekday_abbreviation,
          '%Q' => weekday_name,
          '%q' => weekday_abbreviation
        }
      end

      def weekday_pattern
        @weekday_pattern ||= Regexp.union(weekday_conversion.keys)
      end
  end
end
