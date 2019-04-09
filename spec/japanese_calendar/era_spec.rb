# frozen_string_literal: true

require 'spec_helper'

describe JapaneseCalendar::Era do
  shared_context 'during the Heisei period' do
    let(:period) do
      described_class.new(1989, 1, 8)..described_class.new(2019, 4, 30)
    end
  end

  shared_context 'during the Showa period' do
    let(:period) do
      described_class.new(1926, 12, 25)..described_class.new(1989, 1, 7)
    end
  end

  shared_context 'during the Taisho period' do
    let(:period) do
      described_class.new(1912, 7, 30)..described_class.new(1926, 12, 24)
    end
  end

  shared_context 'during the Meiji period' do
    let(:period) do
      described_class.new(1873, 1, 1)..described_class.new(1912, 7, 29)
    end
  end

  shared_examples 'a era' do
    describe '#era_name' do
      context 'in the Reiwa period' do
        let(:beginning_of_period) { subject.class.new(2019, 5, 1) }

        context 'in kanji' do
          let(:character) { :kanji }

          it 'returns "令和"' do
            expect(beginning_of_period.era_name(character)).to eq('令和')
          end
        end

        context 'in romaji' do
          let(:character) { :romaji }

          it 'returns "Reiwa"' do
            expect(beginning_of_period.era_name(character)).to eq('Reiwa')
          end
        end
      end

      context 'in the Heisei period' do
        include_context 'during the Heisei period'

        context 'in kanji' do
          let(:character) { :kanji }

          it 'returns "平成"' do
            expect(period.first.era_name(character)).to eq('平成')
            expect(period.last.era_name(character)).to  eq('平成')
          end
        end

        context 'in romaji' do
          let(:character) { :romaji }

          it 'returns "Heisei"' do
            expect(period.first.era_name(character)).to eq('Heisei')
            expect(period.last.era_name(character)).to  eq('Heisei')
          end
        end
      end

      context 'in the Showa period' do
        include_context 'during the Showa period'

        context 'in kanji' do
          let(:character) { :kanji }

          it 'returns "昭和"' do
            expect(period.first.era_name(character)).to eq('昭和')
            expect(period.last.era_name(character)).to  eq('昭和')
          end
        end

        context 'in romaji' do
          let(:character) { :romaji }

          it 'returns "Showa"' do
            expect(period.first.era_name(character)).to eq('Showa')
            expect(period.last.era_name(character)).to  eq('Showa')
          end
        end
      end

      context 'in the Taisho period' do
        include_context 'during the Taisho period'

        context 'in kanji' do
          let(:character) { :kanji }

          it 'returns "大正"' do
            expect(period.first.era_name(character)).to eq('大正')
            expect(period.last.era_name(character)).to  eq('大正')
          end
        end

        context 'in romaji' do
          let(:character) { :romaji }

          it 'returns "Taisho"' do
            expect(period.first.era_name(character)).to eq('Taisho')
            expect(period.last.era_name(character)).to  eq('Taisho')
          end
        end
      end

      context 'in the Meiji period' do
        include_context 'during the Meiji period'

        context 'in kanji' do
          let(:character) { :kanji }

          it 'returns "明治"' do
            expect(period.first.era_name(character)).to eq('明治')
            expect(period.last.era_name(character)).to  eq('明治')
          end
        end

        context 'in romaji' do
          let(:character) { :romaji }

          it 'returns "Meiji"' do
            expect(period.first.era_name(character)).to eq('Meiji')
            expect(period.last.era_name(character)).to  eq('Meiji')
          end
        end
      end

      context 'before 1 January 1873 (Meiji 6)' do
        let(:before_meiji_6) { subject.class.new(1872, 12, 31) }

        it 'raises an error' do
          expect do
            before_meiji_6.era_name
          end.to raise_error(RuntimeError, "#{subject.class.name.downcase} out of range")
        end
      end

      context 'with an invalid character' do
        let(:invalid_character) { :emoji }

        it 'raises an error' do
          expect do
            subject.class.new.era_name(:invalid_character)
          end.to raise_error(ArgumentError, 'invalid character')
        end
      end
    end

    describe '#era_year' do
      context 'on the first day of the Reiwa period' do
        let(:first_day_of_period) { subject.class.new(2019, 5, 1) }

        it 'returns 1' do
          expect(first_day_of_period.era_year).to eq(1)
        end
      end

      context 'on the last day of the Heisei period' do
        let(:last_day_of_period) { subject.class.new(2019, 4, 30) }

        it 'returns 31' do
          expect(last_day_of_period.era_year).to eq(31)
        end
      end

      context 'on the first day of the Heisei period' do
        let(:first_day_of_period) { subject.class.new(1989, 1, 8) }

        it 'returns 1' do
          expect(first_day_of_period.era_year).to eq(1)
        end
      end

      context 'on the last day of the Showa period' do
        let(:last_day_of_period) { subject.class.new(1989, 1, 7) }

        it 'returns 64' do
          expect(last_day_of_period.era_year).to eq(64)
        end
      end

      context 'on the first day of the Showa period' do
        let(:first_day_of_period) { subject.class.new(1926, 12, 25) }

        it 'returns 1' do
          expect(first_day_of_period.era_year).to eq(1)
        end
      end

      context 'on the last day of the Taisho period' do
        let(:last_day_of_period) { subject.class.new(1926, 12, 24) }

        it 'returns 15' do
          expect(last_day_of_period.era_year).to eq(15)
        end
      end

      context 'on the first day of the Taisho period' do
        let(:first_day_of_period) { subject.class.new(1912, 7, 30) }

        it 'returns 1' do
          expect(first_day_of_period.era_year).to eq(1)
        end
      end

      context 'on the last day of the Meiji period' do
        let(:last_day_of_period) { subject.class.new(1912, 7, 29) }

        it 'returns 45' do
          expect(last_day_of_period.era_year).to eq(45)
        end
      end

      context 'on 1 January 1873 (Meiji 6)' do
        let(:meiji_6_jan_1) { subject.class.new(1873, 1, 1) }

        it 'returns 6' do
          expect(meiji_6_jan_1.era_year).to eq(6)
        end
      end

      context 'before 1 January 1873 (Meiji 6)' do
        let(:before_meiji_6) { subject.class.new(1872, 12, 31) }

        it 'raises an error' do
          expect do
            before_meiji_6.era_name
          end.to raise_error(RuntimeError, "#{subject.class.name.downcase} out of range")
        end
      end
    end

    describe '#reiwa?' do
      context 'in the Reiwa period' do
        let(:beginning_of_period) { subject.class.new(2019, 5, 1) }

        it 'returns true' do
          expect(beginning_of_period.reiwa?).to be(true)
        end
      end

      context 'in the Heisei period' do
        include_context 'during the Heisei period'

        it 'returns false' do
          expect(period.first.reiwa?).to be(false)
          expect(period.last.reiwa?).to  be(false)
        end
      end

      context 'in the Showa period' do
        include_context 'during the Showa period'

        it 'returns false' do
          expect(period.first.reiwa?).to be(false)
          expect(period.last.reiwa?).to  be(false)
        end
      end

      context 'in the Taisho period' do
        include_context 'during the Taisho period'

        it 'returns false' do
          expect(period.first.reiwa?).to be(false)
          expect(period.last.reiwa?).to  be(false)
        end
      end

      context 'in the Meiji period' do
        include_context 'during the Meiji period'

        it 'returns false' do
          expect(period.first.reiwa?).to be(false)
          expect(period.last.reiwa?).to  be(false)
        end
      end

      context 'before 1 January 1873 (Meiji 6)' do
        let(:before_meiji_6) { subject.class.new(1872, 12, 31) }

        it 'returns false' do
          expect(before_meiji_6.reiwa?).to be(false)
        end
      end
    end

    describe '#heisei?' do
      context 'in the Reiwa period' do
        let(:beginning_of_period) { subject.class.new(2019, 5, 1) }

        it 'returns false' do
          expect(beginning_of_period.heisei?).to be(false)
        end
      end

      context 'in the Heisei period' do
        include_context 'during the Heisei period'

        it 'returns true' do
          expect(period.first.heisei?).to be(true)
          expect(period.last.heisei?).to  be(true)
        end
      end

      context 'in the Showa period' do
        include_context 'during the Showa period'

        it 'returns false' do
          expect(period.first.heisei?).to be(false)
          expect(period.last.heisei?).to  be(false)
        end
      end

      context 'in the Taisho period' do
        include_context 'during the Taisho period'

        it 'returns false' do
          expect(period.first.heisei?).to be(false)
          expect(period.last.heisei?).to  be(false)
        end
      end

      context 'in the Meiji period' do
        include_context 'during the Meiji period'

        it 'returns false' do
          expect(period.first.heisei?).to be(false)
          expect(period.last.heisei?).to  be(false)
        end
      end

      context 'before 1 January 1873 (Meiji 6)' do
        let(:before_meiji_6) { subject.class.new(1872, 12, 31) }

        it 'returns false' do
          expect(before_meiji_6.heisei?).to be(false)
        end
      end
    end

    describe '#showa?' do
      context 'in the Reiwa period' do
        let(:beginning_of_period) { subject.class.new(2019, 5, 1) }

        it 'returns false' do
          expect(beginning_of_period.showa?).to be(false)
        end
      end

      context 'in the Heisei period' do
        include_context 'during the Heisei period'

        it 'returns false' do
          expect(period.first.showa?).to be(false)
          expect(period.last.showa?).to  be(false)
        end
      end

      context 'in the Showa period' do
        include_context 'during the Showa period'

        it 'returns true' do
          expect(period.first.showa?).to be(true)
          expect(period.last.showa?).to  be(true)
        end
      end

      context 'in the Taisho period' do
        include_context 'during the Taisho period'

        it 'returns false' do
          expect(period.first.showa?).to be(false)
          expect(period.last.showa?).to  be(false)
        end
      end

      context 'in the Meiji period' do
        include_context 'during the Meiji period'

        it 'returns false' do
          expect(period.first.showa?).to be(false)
          expect(period.last.showa?).to  be(false)
        end
      end

      context 'before 1 January 1873 (Meiji 6)' do
        let(:before_meiji_6) { subject.class.new(1872, 12, 31) }

        it 'returns false' do
          expect(before_meiji_6.showa?).to be(false)
        end
      end
    end

    describe '#taisho?' do
      context 'in the Reiwa period' do
        let(:beginning_of_period) { subject.class.new(2019, 5, 1) }

        it 'returns false' do
          expect(beginning_of_period.taisho?).to be(false)
        end
      end

      context 'in the Heisei period' do
        include_context 'during the Heisei period'

        it 'returns false' do
          expect(period.first.taisho?).to be(false)
          expect(period.last.taisho?).to  be(false)
        end
      end

      context 'in the Showa period' do
        include_context 'during the Showa period'

        it 'returns false' do
          expect(period.first.taisho?).to be(false)
          expect(period.last.taisho?).to  be(false)
        end
      end

      context 'in the Taisho period' do
        include_context 'during the Taisho period'

        it 'returns true' do
          expect(period.first.taisho?).to be(true)
          expect(period.last.taisho?).to  be(true)
        end
      end

      context 'in the Meiji period' do
        include_context 'during the Meiji period'

        it 'returns false' do
          expect(period.first.taisho?).to be(false)
          expect(period.last.taisho?).to  be(false)
        end
      end

      context 'before 1 January 1873 (Meiji 6)' do
        let(:before_meiji_6) { subject.class.new(1872, 12, 31) }

        it 'returns false' do
          expect(before_meiji_6.taisho?).to be(false)
        end
      end
    end

    describe '#meiji?' do
      context 'in the Reiwa period' do
        let(:beginning_of_period) { subject.class.new(2019, 5, 1) }

        it 'returns false' do
          expect(beginning_of_period.meiji?).to be(false)
        end
      end

      context 'in the Heisei period' do
        include_context 'during the Heisei period'

        it 'returns false' do
          expect(period.first.meiji?).to be(false)
          expect(period.last.meiji?).to  be(false)
        end
      end

      context 'in the Showa period' do
        include_context 'during the Showa period'

        it 'returns false' do
          expect(period.first.meiji?).to be(false)
          expect(period.last.meiji?).to  be(false)
        end
      end

      context 'in the Taisho period' do
        include_context 'during the Taisho period'

        it 'returns false' do
          expect(period.first.meiji?).to be(false)
          expect(period.last.meiji?).to  be(false)
        end
      end

      context 'in the Meiji period' do
        include_context 'during the Meiji period'

        it 'returns true' do
          expect(period.first.meiji?).to be(true)
          expect(period.last.meiji?).to  be(true)
        end
      end

      context 'before 1 January 1873 (Meiji 6)' do
        let(:before_meiji_6) { subject.class.new(1872, 12, 31) }

        it 'returns false' do
          expect(before_meiji_6.meiji?).to be(false)
        end
      end
    end

    describe '#strftime' do
      let(:time) { subject.class.new(2019, 5, 1) }

      context 'with %JN format' do
        let(:format) { '%JN' }

        it 'returns the era name' do
          expect(time.strftime(format)).to eq('令和')
        end
      end

      context 'with %Jn format' do
        let(:format) { '%Jn' }

        it 'returns the abbreviated era name' do
          expect(time.strftime(format)).to eq('令')
        end
      end

      context 'with %JR format' do
        let(:format) { '%JR' }

        it 'returns the era name in romaji' do
          expect(time.strftime(format)).to eq('Reiwa')
        end
      end

      context 'with %^JR format' do
        let(:format) { '%^JR' }

        it 'returns the uppercased era name in romaji' do
          expect(time.strftime(format)).to eq('REIWA')
        end
      end

      context 'with %Jr format' do
        let(:format) { '%Jr' }

        it 'returns the abbreviated era name in romaji' do
          expect(time.strftime(format)).to eq('R')
        end
      end

      context 'with %Jy format' do
        let(:format) { '%Jy' }

        it 'returns a string representing the era year (zero-padded)' do
          expect(time.strftime(format)).to eq('01')
        end
      end

      context 'with %-Jy format' do
        let(:format) { '%-Jy' }

        it 'returns a string representing the era year' do
          expect(time.strftime(format)).to eq('1')
        end
      end

      context 'with %_Jy format' do
        let(:format) { '%_Jy' }

        it 'returns a string representing the era year (blank-padded)' do
          expect(time.strftime(format)).to eq(' 1')
        end
      end

      context 'with %K format' do
        let(:format) { '%K' }

        it 'returns the era name with a warning' do
          expect(time.strftime(format)).to eq('令和')
          expect do
            time.strftime(format)
          end.to output(/%K is deprecated. Please use %JN instead./).to_stderr
        end
      end

      context 'with %O format' do
        let(:format) { '%O' }

        it 'returns the era name in romaji with a warning' do
          expect(time.strftime(format)).to eq('Reiwa')
          expect do
            time.strftime(format)
          end.to output(/%O is deprecated. Please use %JR instead./).to_stderr
        end
      end

      context 'with %^O format' do
        let(:format) { '%^O' }

        it 'returns the uppercased era name in romaji with a warning' do
          expect(time.strftime(format)).to eq('REIWA')
          expect do
            time.strftime(format)
          end.to output(/%\^O is deprecated. Please use %\^JR instead./).to_stderr
        end
      end

      context 'with %o format' do
        let(:format) { '%o' }

        it 'returns the abbreviated era name in romaji with a warning' do
          expect(time.strftime(format)).to eq('R')
          expect do
            time.strftime(format)
          end.to output(/%o is deprecated. Please use %Jr instead./).to_stderr
        end
      end

      context 'with %J format' do
        let(:format) { '%J' }

        it 'returns a string representing the era year (zero-padded) with a warning' do
          expect(time.strftime(format)).to eq('01')
          expect do
            time.strftime(format)
          end.to output(/%J is deprecated. Please use %Jy instead./).to_stderr
        end
      end

      context 'with %-J format' do
        let(:format) { '%-J' }

        it 'returns a string representing the era year with a warning' do
          expect(time.strftime(format)).to eq('1')
          expect do
            time.strftime(format)
          end.to output(/%-J is deprecated. Please use %-Jy instead./).to_stderr
        end
      end

      context 'with %_J format' do
        let(:format) { '%_J' }

        it 'returns a string representing the era year (blank-padded) with a warning' do
          expect(time.strftime(format)).to eq(' 1')
          expect do
            time.strftime(format)
          end.to output(/%_J is deprecated. Please use %_Jy instead./).to_stderr
        end
      end
    end
  end

  describe DateTime do
    it_behaves_like 'a era'
  end

  describe Date do
    it_behaves_like 'a era'
  end

  describe Time do
    it_behaves_like 'a era'
  end
end
