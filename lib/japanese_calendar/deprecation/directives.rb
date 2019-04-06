# frozen_string_literal: true

require 'japanese_calendar/deprecation/reporting'

module JapaneseCalendar
  module Deprecation
    module Directives #:nodoc:
      include JapaneseCalendar::Deprecation::Reporting

      WEEKDAY_MESSAGES = {
        '%Q' => 'Please use %JA instead.',
        '%q' => 'Please use %Ja instead.'
      }.freeze

      ERA_MESSAGES = {
        '%K' => 'Please use %JN instead.',
        '%O' => 'Please use %JR instead.',
        '%^O' => 'Please use %^JR instead.',
        '%o' => 'Please use %Jr instead.',
        '%J' => 'Please use %Jy instead.',
        '%-J' => 'Please use %-Jy instead.',
        '%_J' => 'Please use %_Jy instead.'
      }.freeze

      MESSAGES = WEEKDAY_MESSAGES.merge(ERA_MESSAGES).freeze

      PATTERN = Regexp.union(MESSAGES.keys)

      private_constant :WEEKDAY_MESSAGES, :ERA_MESSAGES, :MESSAGES, :PATTERN

      def strftime(format)
        string = super(format)
        deprecations = collect_japanese_era_deprecations(string)
        deprecations.each { |deprecation| deprecate(*deprecation) }
        string.gsub(deprecated_pattern, deprecated_conversion)
      end

      private

      def collect_japanese_era_deprecations(format)
        deprecated_directives = format.scan(PATTERN).uniq
        MESSAGES.select do |directive, _|
          deprecated_directives.include?(directive)
        end
      end

      def deprecated_weekday_conversion
        {
          '%Q' => weekday_name,
          '%q' => weekday_abbreviation
        }
      end

      def deprecated_era_conversion
        {
          '%K' => era_kanji_name,
          '%O' => era_romaji_name,
          '%^O' => era_romaji_uppercased_name,
          '%o' => era_romaji_abbreviation,
          '%J' => era_year_zero_padded_string,
          '%-J' => era_year_string,
          '%_J' => era_year_blank_padded_string
        }
      end

      def deprecated_conversion
        deprecated_weekday_conversion.merge(deprecated_era_conversion)
      end

      def deprecated_pattern
        Regexp.union(deprecated_conversion.keys)
      end
    end
  end
end
