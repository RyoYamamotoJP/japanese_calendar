# frozen_string_literal: true

module JapaneseCalendar
  module Deprecator #:nodoc:
    private

    def deprecate(directive, message)
      warn "#{directive} is deprecated. #{message}"
    end
  end
end
