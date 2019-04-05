# frozen_string_literal: true

module JapaneseCalendar
  module Weekday
    # calc
    module Calculations
      WEEKDAY_NAMES = %w[日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日].freeze

      private_constant :WEEKDAY_NAMES

      private

      # Returns a string representing the full name of the day of the week in
      # Japanese ("日曜日").
      def weekday_name
        WEEKDAY_NAMES[wday]
      end

      # Returns a string representing the abbreviated name of the day of the
      # week in Japanese ("日").
      def weekday_abbreviation
        weekday_name[0]
      end
    end
  end
end
