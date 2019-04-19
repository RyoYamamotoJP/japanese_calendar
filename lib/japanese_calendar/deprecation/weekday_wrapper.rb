# frozen_string_literal: true

require 'japanese_calendar/deprecation/reporting'

module JapaneseCalendar
  module Deprecation #:nodoc: all
    WEEKDAY_DIRECTIVES = {
      '%Q' => '%JA',
      '%q' => '%Ja'
    }.freeze

    WEEKDAY_PATTERN = Regexp.union(WEEKDAY_DIRECTIVES.keys)

    private_constant :WEEKDAY_DIRECTIVES, :WEEKDAY_PATTERN

    # Prepend wrapper for Weekday module
    module WeekdayWrapper
      include JapaneseCalendar::Deprecation::Reporting

      def strftime(format)
        string = super(format)
        deprecations = collect_weekday_deprecations(string)
        deprecations.each { |deprecation| deprecate_directive(*deprecation) }
        string.gsub(deprecated_weekday_pattern, deprecated_weekday_conversion)
      end

      private

      def collect_weekday_deprecations(format)
        deprecated_directives = format.scan(WEEKDAY_PATTERN).uniq
        WEEKDAY_DIRECTIVES.select do |directive, _|
          deprecated_directives.include?(directive)
        end
      end

      def deprecated_weekday_conversion
        {
          '%Q' => japanese_weekday_name,
          '%q' => japanese_weekday_abbreviated_name
        }
      end

      def deprecated_weekday_pattern
        Regexp.union(deprecated_weekday_conversion.keys)
      end
    end
  end
end
