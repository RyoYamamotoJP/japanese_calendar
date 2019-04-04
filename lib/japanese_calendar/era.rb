# frozen_string_literal: true

require 'japanese_calendar/deprecator'

module JapaneseCalendar
  module Era
    include Deprecator

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
      unless %i(kanji romaji).include?(character)
        raise ArgumentError, 'invalid character'
      end

      current_era.send("#{character}_name")
    end

    # Returns the Japanese year since 1 January 1873 (Meiji 6).
    #
    #   Time.new(2019,  5,  1).era_year # => 1
    #   Time.new(2019,  4, 30).era_year # => 31
    #   Time.new(1989,  1,  7).era_year # => 64
    #   Time.new(1926, 12, 24).era_year # => 15
    #   Time.new(1912,  7, 29).era_year # => 45
    #
    # Raises an error when the Japanese year cannot be found.
    #
    #   Time.new(1872, 12, 31).era_year # => RuntimeError
    def era_year
      year - current_era.beginning_of_period.year + 1
    end

    # Formats time according to the directives in the given format string.
    #
    #   date_of_birth = Time.new(1978, 7, 19)
    #
    #   date_of_birth.strftime("%JN")  # => "昭和"
    #   date_of_birth.strftime("%JR")  # => "Showa"
    #   date_of_birth.strftime("%^JR") # => "SHOWA"
    #   date_of_birth.strftime("%Jr")  # => "S"
    #   date_of_birth.strftime("%Jy")  # => "53"
    #
    #   date_of_birth.strftime("%JN%-Jy年")  # => "昭和53年"
    #
    # Raises an error when the Japanese year cannot be found.
    #
    #   Time.new(1872, 12, 31).strftime("%JN%-Jy年") # => RuntimeError
    def strftime(format)
      warn_if_deprecated(format)
      string = format.gsub(era_pattern, era_conversion)
      super(string)
    end

    private

      Period = Struct.new(:beginning_of_period, :kanji_name, :romaji_name)

      PERIODS = [
        Period.new(Date.new(2019,  5,  1), '令和', 'Reiwa' ).freeze,
        Period.new(Date.new(1989,  1,  8), '平成', 'Heisei').freeze,
        Period.new(Date.new(1926, 12, 25), '昭和', 'Showa' ).freeze,
        Period.new(Date.new(1912,  7, 30), '大正', 'Taisho').freeze,
        Period.new(Date.new(1868,  1, 25), '明治', 'Meiji' ).freeze
      ].freeze

      MEIJI_6 = Date.new(1873, 1, 1)

      DEPRECATIONS = {
        '%K' => 'Please use %JN instead.',
        '%O' => 'Please use %JR instead.',
        '%^O' => 'Please use %^JR instead.',
        '%o' => 'Please use %Jr instead.',
        '%J' => 'Please use %Jy instead.',
        '%-J' => 'Please use %-Jy instead.',
        '%_J' => 'Please use %_Jy instead.'
      }.freeze

      def current_era
        error_proc = proc { raise "#{self.class.name.downcase} out of range" }
        error_proc.call if self.to_date < MEIJI_6
        PERIODS.find(error_proc) do |period|
          period.beginning_of_period <= self.to_date
        end
      end

      def warn_if_deprecated(format)
        pattern = Regexp.union(DEPRECATIONS.keys)
        directives = format.scan(pattern).uniq
        directives.each { |key| deprecate(key, DEPRECATIONS[key]) }
      end

      def era_conversion
        @era_conversion ||= {
          '%JN' => era_name,
          '%JR' => era_name(:romaji),
          '%^JR' => era_name(:romaji).upcase,
          '%Jr' => era_name(:romaji)[0],
          '%Jy' => '%02d' % era_year,
          '%-Jy' => '%d' % era_year,
          '%_Jy' => '%2d' % era_year,
          '%K' => era_name,
          '%O' => era_name(:romaji),
          '%^O' => era_name(:romaji).upcase,
          '%o' => era_name(:romaji)[0],
          '%J' => '%02d' % era_year,
          '%-J' => '%d' % era_year,
          '%_J' => '%2d' % era_year
        }
      end

      def era_pattern
        Regexp.union(era_conversion.keys)
      end
  end
end
