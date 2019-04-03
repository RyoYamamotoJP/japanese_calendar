# frozen_string_literal: true

module JapaneseCalendar
  module Deprecator
    private

      def deprecate(directive, message)
        warn "#{directive} is deprecated. #{message}"
      end
  end
end
