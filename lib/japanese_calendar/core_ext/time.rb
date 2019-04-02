# frozen_string_literal: true

require "japanese_calendar/era"
require "japanese_calendar/weekday"

class Time
  prepend JapaneseCalendar::Era
  prepend JapaneseCalendar::Weekday
end
