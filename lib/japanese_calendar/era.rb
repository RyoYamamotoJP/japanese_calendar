module JapaneseCalendar
  module Era
    PERIODS = [
      { name: "平成", beginning_of_period: Time.new(1989,  1,  8) },
      { name: "昭和", beginning_of_period: Time.new(1926, 12, 25) },
      { name: "大正", beginning_of_period: Time.new(1912,  7, 30) },
      { name: "明治", beginning_of_period: Time.new(1868,  1, 25) }
    ]

    # Returns the Japanese era name (nengo) since the end of the Edo period.
    #
    #   Time.new(1989,  1,  8).era_name # => "平成"
    #   Time.new(1926, 12, 25).era_name # => "昭和"
    #   Time.new(1912,  7, 30).era_name # => "大正"
    #   Time.new(1868,  1, 25).era_name # => "明治"
    #
    # Raises an error when the Japanese era name cannot be found.
    #
    #   Time.new(1868,  1, 24).era_name # => RuntimeError
    def era_name
      find_era[:name]
    end

    # Returns the Japanese year since the end of the Edo period.
    #
    #   Time.new(2016, 12, 11).era_year # => 28
    #   Time.new(1989,  1,  7).era_year # => 64
    #   Time.new(1926, 12, 24).era_year # => 14
    #   Time.new(1912,  7, 29).era_year # => 45
    #
    # Raises an error when the Japanese year cannot be found.
    #
    #   Time.new(1868,  1, 24).era_year # => RuntimeError
    def era_year
      year - find_era[:beginning_of_period].year + 1
    end

    private
      def find_era
        ifnone = proc { raise "#{self.class.name.downcase} out of range" }
        PERIODS.find(ifnone) { |period| period[:beginning_of_period] <= self }
      end
  end
end
