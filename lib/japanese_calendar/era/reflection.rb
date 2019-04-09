# frozen_string_literal: true

module JapaneseCalendar
  module Era
    module Reflection #:nodoc:
      PERIODS.each do |period|
        define_method "#{period.romaji_name.downcase}?" do
          begin
            period == current_era
          rescue RuntimeError
            false
          end
        end
      end
    end
  end
end
