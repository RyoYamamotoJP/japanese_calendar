# frozen_string_literal: true

require 'japanese_calendar/deprecator'

module JapaneseCalendar
  module Weekday
    module Deprecator
      include JapaneseCalendar::Deprecator

      DEPRECATIONS = {
        '%Q' => 'Please use %JA instead.',
        '%q' => 'Please use %Ja instead.'
      }.freeze

      private_constant :DEPRECATIONS

      def strftime(format)
        deprecations = collect_weekday_deprecations(format)
        deprecations.each { |deprecation| deprecate(*deprecation) }
        super(format)
      end

      private

      def collect_weekday_deprecations(format)
        deprecation_pattern = Regexp.union(DEPRECATIONS.keys)
        deprecated_directives = format.scan(deprecation_pattern).uniq
        DEPRECATIONS.select do |directive, _|
          deprecated_directives.include?(directive)
        end
      end
    end
  end
end
