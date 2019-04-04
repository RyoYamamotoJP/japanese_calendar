# frozen_string_literal: true

require 'japanese_calendar/deprecator'

module JapaneseCalendar
  module Era
    module Deprecator
      include JapaneseCalendar::Deprecator

      DEPRECATIONS = {
        '%K' => 'Please use %JN instead.',
        '%O' => 'Please use %JR instead.',
        '%^O' => 'Please use %^JR instead.',
        '%o' => 'Please use %Jr instead.',
        '%J' => 'Please use %Jy instead.',
        '%-J' => 'Please use %-Jy instead.',
        '%_J' => 'Please use %_Jy instead.'
      }.freeze

      private_constant :DEPRECATIONS

      def strftime(format)
        deprecations = collect_era_deprecations(format)
        deprecations.each { |deprecation| deprecate(*deprecation) }
        super(format)
      end

      private

      def collect_era_deprecations(format)
        deprecation_pattern = Regexp.union(DEPRECATIONS.keys)
        deprecated_directives = format.scan(deprecation_pattern).uniq
        DEPRECATIONS.select do |directive, _|
          deprecated_directives.include?(directive)
        end
      end
    end
  end
end
