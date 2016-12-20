require "japanese_calendar/era"

class Time
  prepend JapaneseCalendar::Era
end
