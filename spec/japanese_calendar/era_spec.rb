# frozen_string_literal: true
require "spec_helper"

describe JapaneseCalendar::Era do
  describe "#era_name" do
    context "in the Heisei period" do
      let(:beginning_of_period) { Time.new(1989, 1, 8) }

      context "in kanji" do
        let(:character) { :kanji }

        it 'returns "平成"' do
          expect(beginning_of_period.era_name(character)).to eq("平成")
        end
      end

      context "in romaji" do
        let(:character) { :romaji }

        it 'returns "Heisei"' do
          expect(beginning_of_period.era_name(character)).to eq("Heisei")
        end
      end
    end

    context "in the Showa period" do
      let(:beginning_of_period) { Time.new(1926, 12, 25,  0,  0,  0) }
      let(:end_of_period)       { Time.new(1989,  1,  7, 23, 59, 59) }

      context "in kanji" do
        let(:character) { :kanji }

        it 'returns "昭和"' do
          expect(beginning_of_period.era_name(character)).to eq("昭和")
          expect(end_of_period.era_name(character)).to       eq("昭和")
        end
      end

      context "in romaji" do
        let(:character) { :romaji }

        it 'returns "Showa"' do
          expect(beginning_of_period.era_name(character)).to eq("Showa")
          expect(end_of_period.era_name(character)).to       eq("Showa")
        end
      end
    end

    context "in the Taisho period" do
      let(:beginning_of_period) { Time.new(1912,  7, 30,  0,  0,  0) }
      let(:end_of_period)       { Time.new(1926, 12, 24, 23, 59, 59) }

      context "in kanji" do
        let(:character) { :kanji }

        it 'returns "大正"' do
          expect(beginning_of_period.era_name(character)).to eq("大正")
          expect(end_of_period.era_name(character)).to       eq("大正")
        end
      end

      context "in romaji" do
        let(:character) { :romaji }

        it 'returns "Taisho"' do
          expect(beginning_of_period.era_name(character)).to eq("Taisho")
          expect(end_of_period.era_name(character)).to       eq("Taisho")
        end
      end
    end

    context "in the Meiji period" do
      let(:beginning_of_period) { Time.new(1873,  1,  1,  0,  0,  0) }
      let(:end_of_period)       { Time.new(1912,  7, 29, 23, 59, 59) }

      context "in kanji" do
        let(:character) { :kanji }

        it 'returns "明治"' do
          expect(beginning_of_period.era_name(character)).to eq("明治")
          expect(end_of_period.era_name(character)).to       eq("明治")
        end
      end

      context "in romaji" do
        let(:character) { :romaji }

        it 'returns "Meiji"' do
          expect(beginning_of_period.era_name(character)).to eq("Meiji")
          expect(end_of_period.era_name(character)).to       eq("Meiji")
        end
      end
    end

    context "before 1 January 1873 (Meiji 6)" do
      let(:before_meiji_6) { Time.new(1872, 12, 31, 23, 59, 59) }

      it "raises an error" do
        expect { before_meiji_6.era_name }.to raise_error(RuntimeError, "time out of range")
      end
    end

    context "with an invalid character" do
      let(:invalid_character) { :emoji }

      it "raises an error" do
        expect { Time.new.era_name(:invalid_character) }.to raise_error(ArgumentError, "invalid character")
      end
    end
  end

  describe "#era_year" do
    context "on the first day of the Heisei period" do
      let(:first_day_of_period) { Time.new(1989, 1, 8) }

      it "returns 1" do
        expect(first_day_of_period.era_year).to eq(1)
      end
    end

    context "on the last day of the Showa period" do
      let(:last_day_of_period) { Time.new(1989, 1, 7) }

      it "returns 64" do
        expect(last_day_of_period.era_year).to eq(64)
      end
    end

    context "on the first day of the Showa period" do
      let(:first_day_of_period) { Time.new(1926, 12, 25) }

      it "returns 1" do
        expect(first_day_of_period.era_year).to eq(1)
      end
    end

    context "on the last day of the Taisho period" do
      let(:last_day_of_period) { Time.new(1926, 12, 24) }

      it "returns 15" do
        expect(last_day_of_period.era_year).to eq(15)
      end
    end

    context "on the first day of the Taisho period" do
      let(:first_day_of_period) { Time.new(1912, 7, 30) }

      it "returns 1" do
        expect(first_day_of_period.era_year).to eq(1)
      end
    end

    context "on the last day of the Meiji period" do
      let(:last_day_of_period) { Time.new(1912, 7, 29) }

      it "returns 45" do
        expect(last_day_of_period.era_year).to eq(45)
      end
    end

    context "on 1 January 1873 (Meiji 6)" do
      let(:meiji_6_jan_1) { Time.new(1873, 1, 1) }

      it "returns 6" do
        expect(meiji_6_jan_1.era_year).to eq(6)
      end
    end

    context "before 1 January 1873 (Meiji 6)" do
      let(:before_meiji_6) { Time.new(1872, 12, 31, 23, 59, 59) }

      it "raises an error" do
        expect do
          before_meiji_6.era_year
        end.to raise_error(RuntimeError, "time out of range")
      end
    end
  end

  describe "#strftime" do
    let(:time) { Time.new(1989, 1, 8) }

    context "with %JN format" do
      let(:format) { "%JN" }

      it "returns the era name" do
        expect(time.strftime(format)).to eq("平成")
      end
    end

    context "with %JR format" do
      let(:format) { "%JR" }

      it "returns the era name in romaji" do
        expect(time.strftime(format)).to eq("Heisei")
      end
    end

    context "with %^JR format" do
      let(:format) { "%^JR" }

      it "returns the uppercased era name in romaji" do
        expect(time.strftime(format)).to eq("HEISEI")
      end
    end

    context "with %Jr format" do
      let(:format) { "%Jr" }

      it "returns the abbreviated era name in romaji" do
        expect(time.strftime(format)).to eq("H")
      end
    end

    context "with %Jy format" do
      let(:format) { "%Jy" }

      it "returns a string representing the era year (zero-padded)" do
        expect(time.strftime(format)).to eq("01")
      end
    end

    context "with %-Jy format" do
      let(:format) { "%-Jy" }

      it "returns a string representing the era year" do
        expect(time.strftime(format)).to eq("1")
      end
    end

    context "with %_Jy format" do
      let(:format) { "%_Jy" }

      it "returns a string representing the era year (blank-padded)" do
        expect(time.strftime(format)).to eq(" 1")
      end
    end

    context "with %K format" do
      let(:format) { "%K" }

      it "returns the era name" do
        expect(time.strftime(format)).to eq("平成")
      end
    end

    context "with %O format" do
      let(:format) { "%O" }

      it "returns the era name in romaji" do
        expect(time.strftime(format)).to eq("Heisei")
      end
    end

    context "with %^O format" do
      let(:format) { "%^O" }

      it "returns the uppercased era name in romaji" do
        expect(time.strftime(format)).to eq("HEISEI")
      end
    end

    context "with %o format" do
      let(:format) { "%o" }

      it "returns the abbreviated era name in romaji" do
        expect(time.strftime(format)).to eq("H")
      end
    end

    context "with %J format" do
      let(:format) { "%J" }

      it "returns a string representing the era year (zero-padded)" do
        expect(time.strftime(format)).to eq("01")
      end
    end

    context "with %-J format" do
      let(:format) { "%-J" }

      it "returns a string representing the era year" do
        expect(time.strftime(format)).to eq("1")
      end
    end

    context "with %_J format" do
      let(:format) { "%_J" }

      it "returns a string representing the era year (blank-padded)" do
        expect(time.strftime(format)).to eq(" 1")
      end
    end
  end
end
