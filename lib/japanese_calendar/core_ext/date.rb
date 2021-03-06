# frozen_string_literal: true

require 'date'
require 'japanese_calendar/era'
require 'japanese_calendar/weekday'

class Date #:nodoc:
  prepend JapaneseCalendar::Era
  prepend JapaneseCalendar::Weekday
end
