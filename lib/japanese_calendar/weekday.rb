# frozen_string_literal: true

module JapaneseCalendar
  module Weekday
    include Deprecator

    NAMES = %w(日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日).freeze
    ABBREVIATIONS = NAMES.map { |name| name[0] }.freeze

    # Formats time according to the directives in the given format string.
    #
    #   date_of_birth = Time.new(1978, 7, 19)
    #
    #   date_of_birth.strftime("%JA")  # => "水曜日"
    #   date_of_birth.strftime("%Ja")  # => "水"
    #
    #   date_of_birth.strftime("%-Y年%-m月%-d日(%q)") # => "1978年7月19日(水)"
    def strftime(format)
      deprecate('%Q', 'Please use %JA instead.') if format =~ /%Q/
      deprecate('%q', 'Please use %Ja instead.') if format =~ /%q/

      pattern = Regexp.union(conversion.keys)
      string = format.gsub(pattern, conversion)
      super(string)
    end

    private

      def conversion
        @conversion ||= {
          '%Q' => NAMES[wday],
          '%q' => ABBREVIATIONS[wday],
          '%JA' => NAMES[wday],
          '%Ja' => ABBREVIATIONS[wday]
        }
      end
  end
end
