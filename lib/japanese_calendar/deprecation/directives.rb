# frozen_string_literal: true

require 'japanese_calendar/deprecation/reporting'

module JapaneseCalendar
  module Deprecation
    module Directives #:nodoc:
      include JapaneseCalendar::Deprecation::Reporting

      MESSAGES = {
        '%Q' => 'Please use %JA instead.',
        '%q' => 'Please use %Ja instead.',
        '%K' => 'Please use %JN instead.',
        '%O' => 'Please use %JR instead.',
        '%^O' => 'Please use %^JR instead.',
        '%o' => 'Please use %Jr instead.',
        '%J' => 'Please use %Jy instead.',
        '%-J' => 'Please use %-Jy instead.',
        '%_J' => 'Please use %_Jy instead.'
      }.freeze

      PATTERN = Regexp.union(MESSAGES.keys)

      private_constant :MESSAGES, :PATTERN

      def strftime(format)
        deprecations = collect_japanese_era_deprecations(format)
        deprecations.each { |deprecation| deprecate(*deprecation) }
        super(format)
      end

      private

      def collect_japanese_era_deprecations(format)
        deprecated_directives = format.scan(PATTERN).uniq
        MESSAGES.select do |directive, _|
          deprecated_directives.include?(directive)
        end
      end
    end
  end
end
