# frozen_string_literal: true
module JapaneseCalendar
  module Era
    # Returns the Japanese era name (nengo) since 1 January 1873 (Meiji 6).
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
      raise ArgumentError unless %i(kanji romaji).include?(character)
      find_era.send("#{character}_name")
    end

    # Returns the Japanese year since 1 January 1873 (Meiji 6).
    #
    #   Time.new(2016, 12, 11).era_year # => 28
    #   Time.new(1989,  1,  7).era_year # => 64
    #   Time.new(1926, 12, 24).era_year # => 15
    #   Time.new(1912,  7, 29).era_year # => 45
    #
    # Raises an error when the Japanese year cannot be found.
    #
    #   Time.new(1872, 12, 31).era_year # => RuntimeError
    def era_year
      year - find_era.beginning_of_period.year + 1
    end

    # Formats time according to the directives in the given format string.
    #
    #   date_of_birth = Time.new(1978, 7, 19)
    #
    #   date_of_birth.strftime("%K")  # => "昭和"
    #   date_of_birth.strftime("%O")  # => "Showa"
    #   date_of_birth.strftime("%^O") # => "SHOWA"
    #   date_of_birth.strftime("%o")  # => "S"
    #   date_of_birth.strftime("%J")  # => "53"
    #
    #   date_of_birth.strftime("%K%-J年")  # => "昭和53年"
    #
    # Raises an error when the Japanese year cannot be found.
    #
    #   Time.new(1872, 12, 31).strftime("%K%-J年") # => RuntimeError
    def strftime(format)
      string = format.dup
      string.gsub!(/%J/,   "%02d" % era_year)
      string.gsub!(/%-J/,  "%d"   % era_year)
      string.gsub!(/%_J/,  "%2d"  % era_year)
      string.gsub!(/%K/,   era_name.to_s)
      string.gsub!(/%O/,   era_name(:romaji).to_s)
      string.gsub!(/%\^O/, era_name(:romaji).upcase.to_s)
      string.gsub!(/%o/,   era_name(:romaji)[0].to_s)
      super(string)
    end

    private
      Period = Struct.new(:beginning_of_period, :kanji_name, :romaji_name)

      MEIJI_6 = Time.new(1873, 1, 1)

      PERIODS = [
        Period.new(Time.new(1989,  1,  8), "平成", "Heisei").freeze,
        Period.new(Time.new(1926, 12, 25), "昭和", "Showa" ).freeze,
        Period.new(Time.new(1912,  7, 30), "大正", "Taisho").freeze,
        Period.new(Time.new(1868,  1, 25), "明治", "Meiji" ).freeze
      ].freeze

      def find_era
        raise "#{self.class.name.downcase} out of range" if self < MEIJI_6

        ifnone = proc { raise "#{self.class.name.downcase} out of range" }
        PERIODS.find(ifnone) { |period| period.beginning_of_period <= self }
      end
  end
end
