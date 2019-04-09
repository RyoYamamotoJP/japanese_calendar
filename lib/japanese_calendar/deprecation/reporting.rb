# frozen_string_literal: true

module JapaneseCalendar
  module Deprecation
    module Reporting #:nodoc:
      private

      def deprecate_directive(directive, replacement)
        deprecate(directive, "Please use #{replacement} instead.")
      end

      def deprecate(directive, message)
        warn "#{directive} is deprecated. #{message}"
      end
    end
  end
end
