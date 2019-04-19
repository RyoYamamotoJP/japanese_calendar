# frozen_string_literal: true

module JapaneseCalendar
  module Weekday #:nodoc:
    ABBREVIATED_NAMES = %w[日 月 火 水 木 金 土].freeze

    private_constant :ABBREVIATED_NAMES

    # Calculations module.
    module Calculations
      private

      # Returns a string representing the full name of the day of the week in
      # Japanese ("日曜日").
      def weekday_name
        "#{weekday_abbreviation}曜日"
      end

      # Returns a string representing the abbreviated name of the day of the
      # week in Japanese ("日").
      def weekday_abbreviation
        ABBREVIATED_NAMES[wday]
      end
    end
  end
end
