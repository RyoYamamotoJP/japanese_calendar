# frozen_string_literal: true
module JapaneseCalendar
  module Weekday
    NAMES = %w(日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日).freeze

    # Formats time according to the directives in the given format string.
    #
    #   date_of_birth = Time.new(1978, 7, 19)
    #
    #   date_of_birth.strftime("%Q")  # => "水曜日"
    #   date_of_birth.strftime("%q")  # => "水"
    #
    #   date_of_birth.strftime("%-Y年%-m月%-d日(%q)") # => "1978年7月19日(水)"
    def strftime(format)
      string = format.dup
      string.gsub!(/%Q/, NAMES[wday])
      string.gsub!(/%q/, NAMES[wday][0])
      super(string)
    end
  end
end
