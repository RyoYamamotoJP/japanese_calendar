# frozen_string_literal: true

require 'japanese_calendar/deprecation/reporting'

module JapaneseCalendar
  module Deprecation #:nodoc: all
    ERA_DIRECTIVES = {
      '%K' => '%JN',
      '%O' => '%JR',
      '%^O' => '%^JR',
      '%o' => '%Jr',
      '%J' => '%Jy',
      '%-J' => '%-Jy',
      '%_J' => '%_Jy'
    }.freeze

    ERA_PATTERN = Regexp.union(ERA_DIRECTIVES.keys)

    private_constant :ERA_DIRECTIVES, :ERA_PATTERN

    # Prepend wrapper for Era module
    module EraWrapper
      include JapaneseCalendar::Deprecation::Reporting

      def strftime(format)
        string = super(format)
        deprecations = collect_era_deprecations(string)
        deprecations.each { |deprecation| deprecate_directive(*deprecation) }
        string.gsub(deprecated_era_pattern, deprecated_era_conversion)
      end

      private

      def collect_era_deprecations(format)
        deprecated_directives = format.scan(ERA_PATTERN).uniq
        ERA_DIRECTIVES.select do |directive, _|
          deprecated_directives.include?(directive)
        end
      end

      def deprecated_era_conversion
        {
          '%K' => japanese_era_kanji_name,
          '%O' => japanese_era_romaji_name,
          '%^O' => japanese_era_romaji_uppercased_name,
          '%o' => japanese_era_romaji_abbreviated_name,
          '%J' => japanese_era_year_zero_padded_string,
          '%-J' => japanese_era_year_string,
          '%_J' => japanese_era_year_blank_padded_string
        }
      end

      def deprecated_era_pattern
        Regexp.union(deprecated_era_conversion.keys)
      end
    end
  end
end
