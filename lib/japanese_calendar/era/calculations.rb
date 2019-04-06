# frozen_string_literal: true

module JapaneseCalendar
  module Era
    # Calculations module.
    module Calculations
      Period = Struct.new(:beginning_of_period, :kanji_name, :romaji_name)

      MEIJI_6 = Date.new(1873, 1, 1)

      PERIODS = [
        Period.new(Date.new(2019,  5,  1), '令和', 'Reiwa').freeze,
        Period.new(Date.new(1989,  1,  8), '平成', 'Heisei').freeze,
        Period.new(Date.new(1926, 12, 25), '昭和', 'Showa').freeze,
        Period.new(Date.new(1912,  7, 30), '大正', 'Taisho').freeze,
        Period.new(Date.new(1868,  1, 25), '明治', 'Meiji').freeze
      ].freeze

      private_constant :Period, :MEIJI_6, :PERIODS

      # Returns the Japanese era name (nengo) since 1 January 1873 (Meiji 6).
      #
      #   reiwa = Time.new(2019, 5, 1)   # => 2019-05-01 00:00:00 +0900
      #   reiwa.era_name                 # => "令和"
      #   reiwa.era_name(:romaji)        # => "Reiwa"
      #
      #   heisei = Time.new(1989, 1, 8)  # => 1989-01-08 00:00:00 +0900
      #   heisei.era_name                # => "平成"
      #   heisei.era_name(:romaji)       # => "Heisei"
      #
      #   showa = Time.new(1926, 12, 25) # => 1926-12-25 00:00:00 +0900
      #   showa.era_name                 # => "昭和"
      #   showa.era_name(:romaji)        # => "Showa"
      #
      #   taisho = Time.new(1912, 7, 30) # => 1912-07-30 00:00:00 +0900
      #   taisho.era_name                # => "大正"
      #   taisho.era_name(:romaji)       # => "Taisho"
      #
      #   meiji = Time.new(1873, 1, 1)   # => 1873-01-01 00:00:00 +0900
      #   meiji.era_name                 # => "明治"
      #   meiji.era_name(:romaji)        # => "Meiji"
      #
      # Raises an error when the Japanese era name cannot be found.
      #
      #   Time.new(1872, 12, 31).era_name # => RuntimeError
      def era_name(character = :kanji)
        unless %i[kanji romaji].include?(character)
          raise ArgumentError, 'invalid character'
        end

        current_era.send("#{character}_name")
      end

      # Returns the year of the Japanese era since 1 January 1873 (Meiji 6).
      #
      #   Time.new(2019,  5,  1).era_year # => 1
      #   Time.new(2019,  4, 30).era_year # => 31
      #   Time.new(1989,  1,  7).era_year # => 64
      #   Time.new(1926, 12, 24).era_year # => 15
      #   Time.new(1912,  7, 29).era_year # => 45
      #
      # Raises an error when the year of the Japanese era cannot be found.
      #
      #   Time.new(1872, 12, 31).era_year # => RuntimeError
      def era_year
        year - current_era.beginning_of_period.year + 1
      end

      private

      def current_era
        error_proc = proc { raise "#{self.class.name.downcase} out of range" }
        error_proc.call if to_date < MEIJI_6
        PERIODS.find(error_proc) do |period|
          period.beginning_of_period <= to_date
        end
      end

      # Returns a string representing the full name of the Japanese era in
      # Kanji ("令和").
      def era_kanji_name
        era_name(:kanji)
      end

      # Returns a string representing the full name of the Japanese era in
      # Romaji ("Reiwa").
      def era_romaji_name
        era_name(:romaji)
      end

      # Returns a string representing the uppercased full name of the Japanese
      # era in Romaji ("REIWA").
      def era_romaji_uppercased_name
        era_romaji_name.upcase
      end

      # Returns a string representing the abbreviated name of the Japanese era
      # in Romaji ("R").
      def era_romaji_abbreviation
        era_romaji_name[0]
      end

      # Returns a string representing the year of the Japanese era ("1")
      def era_year_string
        '%-d' % era_year
      end

      # Returns a string representing the zero-padded year of the Japanese era
      # ("01").
      def era_year_zero_padded_string
        '%02d' % era_year
      end

      # Returns a string representing the blank-padded year of the Japanese era
      # (" 1").
      def era_year_blank_padded_string
        '%2d' % era_year
      end
    end
  end
end
