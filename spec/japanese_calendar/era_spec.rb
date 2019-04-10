# frozen_string_literal: true

require 'spec_helper'

describe JapaneseCalendar::Era do
  shared_examples '#era_name examples' do |*expected|
    kanji, romaji = expected

    describe '#era_name' do
      context 'with :kanji' do
        it "returns \"#{kanji}\"" do
          expect(subject.era_name(:kanji)).to eq(kanji)
        end
      end

      context 'with :romaji' do
        it "returns \"#{romaji}\"" do
          expect(subject.era_name(:romaji)).to eq(romaji)
        end
      end

      context 'with an invalid character' do
        it 'raises an error' do
          expect do
            subject.era_name(:emoji)
          end.to raise_error(ArgumentError).with_message('invalid character')
        end
      end
    end
  end

  shared_examples '#era_year examples' do |expected|
    describe '#era_year' do
      it "returns #{expected}" do
        expect(subject.era_year).to eq(expected)
      end
    end
  end

  shared_examples '#reiwa? examples' do |expected|
    describe '#reiwa?' do
      it "returns #{expected}" do
        expect(subject.reiwa?).to be(expected)
      end
    end
  end

  shared_examples '#heisei? examples' do |expected|
    describe '#heisei?' do
      it "returns #{expected}" do
        expect(subject.heisei?).to be(expected)
      end
    end
  end

  shared_examples '#showa? examples' do |expected|
    describe '#showa?' do
      it "returns #{expected}" do
        expect(subject.showa?).to be(expected)
      end
    end
  end

  shared_examples '#taisho? examples' do |expected|
    describe '#taisho?' do
      it "returns #{expected}" do
        expect(subject.taisho?).to be(expected)
      end
    end
  end

  shared_examples '#meiji? examples' do |expected|
    describe '#meiji?' do
      it "returns #{expected}" do
        expect(subject.meiji?).to be(expected)
      end
    end
  end

  shared_examples '#strftime examples' do |*expected|
    kanji_full_name, kanji_abbreviated_name, romaji_full_name,
    romaji_uppercased_name, romaji_abbreviated_name, zero_padded_year_string,
    year_string, blank_padded_year_string = expected

    describe '#strftime' do
      context 'with "%JN" format' do
        it "returns \"#{kanji_full_name}\"" do
          expect(subject.strftime('%JN')).to eq(kanji_full_name)
        end
      end

      context 'with "%Jn" format' do
        it "returns \"#{kanji_abbreviated_name}\"" do
          expect(subject.strftime('%Jn')).to eq(kanji_abbreviated_name)
        end
      end

      context 'with "%JR" format' do
        it "returns \"#{romaji_full_name}\"" do
          expect(subject.strftime('%JR')).to eq(romaji_full_name)
        end
      end

      context 'with "%^JR" format' do
        it "returns \"#{romaji_uppercased_name}\"" do
          expect(subject.strftime('%^JR')).to eq(romaji_uppercased_name)
        end
      end

      context 'with "%Jr" format' do
        it "returns \"#{romaji_abbreviated_name}\"" do
          expect(subject.strftime('%Jr')).to eq(romaji_abbreviated_name)
        end
      end

      context 'with "%Jy" format' do
        it "returns \"#{zero_padded_year_string}\"" do
          expect(subject.strftime('%Jy')).to eq(zero_padded_year_string)
        end
      end

      context 'with "%-Jy" format' do
        it "returns \"#{year_string}\"" do
          expect(subject.strftime('%-Jy')).to eq(year_string)
        end
      end

      context 'with "%_Jy" format' do
        it "returns \"#{blank_padded_year_string}\"" do
          expect(subject.strftime('%_Jy')).to eq(blank_padded_year_string)
        end
      end

      context 'with "%K" format' do
        it "returns \"#{kanji_full_name}\" with a warning" do
          expect(subject.strftime('%K')).to eq(kanji_full_name)
          expect do
            subject.strftime('%K')
          end.to output(/%K is deprecated. Please use %JN instead./)
            .to_stderr
        end
      end

      context 'with "%O" format' do
        it "returns \"#{romaji_full_name}\" with a warning" do
          expect(subject.strftime('%O')).to eq(romaji_full_name)
          expect do
            subject.strftime('%O')
          end.to output(/%O is deprecated. Please use %JR instead./)
            .to_stderr
        end
      end

      context 'with "%^O" format' do
        it "returns \"#{romaji_uppercased_name}\" with a warning" do
          expect(subject.strftime('%^O')).to eq(romaji_uppercased_name)
          expect do
            subject.strftime('%^O')
          end.to output(/%\^O is deprecated. Please use %\^JR instead./)
            .to_stderr
        end
      end

      context 'with "%o" format' do
        it "returns \"#{romaji_abbreviated_name}\" with a warning" do
          expect(subject.strftime('%o')).to eq(romaji_abbreviated_name)
          expect do
            subject.strftime('%o')
          end.to output(/%o is deprecated. Please use %Jr instead./)
            .to_stderr
        end
      end

      context 'with "%J" format' do
        it "returns \"#{zero_padded_year_string}\" with a warning" do
          expect(subject.strftime('%J')).to eq(zero_padded_year_string)
          expect do
            subject.strftime('%J')
          end.to output(/%J is deprecated. Please use %Jy instead./)
            .to_stderr
        end
      end

      context 'with "%-J" format' do
        it "returns \"#{year_string}\" with a warning" do
          expect(subject.strftime('%-J')).to eq(year_string)
          expect do
            subject.strftime('%-J')
          end.to output(/%-J is deprecated. Please use %-Jy instead./)
            .to_stderr
        end
      end

      context 'with "%_J" format' do
        it "returns \"#{blank_padded_year_string}\" with a warning" do
          expect(subject.strftime('%_J')).to eq(blank_padded_year_string)
          expect do
            subject.strftime('%_J')
          end.to output(/%_J is deprecated. Please use %_Jy instead./)
            .to_stderr
        end
      end
    end
  end

  shared_examples 'an era' do
    context 'on the first day of the Reiwa period' do
      subject { described_class.new(2019, 5, 1) }
      include_examples '#era_name examples', '令和', 'Reiwa'
      include_examples '#era_year examples', 1
      include_examples '#reiwa? examples', true
      include_examples '#heisei? examples', false
      include_examples '#showa? examples', false
      include_examples '#taisho? examples', false
      include_examples '#meiji? examples', false
      include_examples '#strftime examples', '令和', '令', 'Reiwa', 'REIWA',
                       'R', '01', '1', ' 1'
    end

    context 'on the last day of the Heisei period' do
      subject { described_class.new(2019, 4, 30) }
      include_examples '#era_name examples', '平成', 'Heisei'
      include_examples '#era_year examples', 31
      include_examples '#reiwa? examples', false
      include_examples '#heisei? examples', true
      include_examples '#showa? examples', false
      include_examples '#taisho? examples', false
      include_examples '#meiji? examples', false
      include_examples '#strftime examples', '平成', '平', 'Heisei', 'HEISEI',
                       'H', '31', '31', '31'
    end

    context 'on the first day of the Heisei period' do
      subject { described_class.new(1989, 1, 8) }
      include_examples '#era_name examples', '平成', 'Heisei'
      include_examples '#era_year examples', 1
      include_examples '#reiwa? examples', false
      include_examples '#heisei? examples', true
      include_examples '#showa? examples', false
      include_examples '#taisho? examples', false
      include_examples '#meiji? examples', false
      include_examples '#strftime examples', '平成', '平', 'Heisei', 'HEISEI',
                       'H', '01', '1', ' 1'
    end

    context 'on the last day of the Showa period' do
      subject { described_class.new(1989, 1, 7) }
      include_examples '#era_name examples', '昭和', 'Showa'
      include_examples '#era_year examples', 64
      include_examples '#reiwa? examples', false
      include_examples '#heisei? examples', false
      include_examples '#showa? examples', true
      include_examples '#taisho? examples', false
      include_examples '#meiji? examples', false
      include_examples '#strftime examples', '昭和', '昭', 'Showa', 'SHOWA',
                       'S', '64', '64', '64'
    end

    context 'on the first day of the Showa period' do
      subject { described_class.new(1926, 12, 25) }
      include_examples '#era_name examples', '昭和', 'Showa'
      include_examples '#era_year examples', 1
      include_examples '#reiwa? examples', false
      include_examples '#heisei? examples', false
      include_examples '#showa? examples', true
      include_examples '#taisho? examples', false
      include_examples '#meiji? examples', false
      include_examples '#strftime examples', '昭和', '昭', 'Showa', 'SHOWA',
                       'S', '01', '1', ' 1'
    end

    context 'on the last day of the Taisho period' do
      subject { described_class.new(1926, 12, 24) }
      include_examples '#era_name examples', '大正', 'Taisho'
      include_examples '#era_year examples', 15
      include_examples '#reiwa? examples', false
      include_examples '#heisei? examples', false
      include_examples '#showa? examples', false
      include_examples '#taisho? examples', true
      include_examples '#meiji? examples', false
      include_examples '#strftime examples', '大正', '大', 'Taisho', 'TAISHO',
                       'T', '15', '15', '15'
    end

    context 'on the first day of the Taisho period' do
      subject { described_class.new(1912, 7, 30) }
      include_examples '#era_name examples', '大正', 'Taisho'
      include_examples '#era_year examples', 1
      include_examples '#reiwa? examples', false
      include_examples '#heisei? examples', false
      include_examples '#showa? examples', false
      include_examples '#taisho? examples', true
      include_examples '#meiji? examples', false
      include_examples '#strftime examples', '大正', '大', 'Taisho', 'TAISHO',
                       'T', '01', '1', ' 1'
    end

    context 'on the last day of the Meiji period' do
      subject { described_class.new(1912, 7, 29) }
      include_examples '#era_name examples', '明治', 'Meiji'
      include_examples '#era_year examples', 45
      include_examples '#reiwa? examples', false
      include_examples '#heisei? examples', false
      include_examples '#showa? examples', false
      include_examples '#taisho? examples', false
      include_examples '#meiji? examples', true
      include_examples '#strftime examples', '明治', '明', 'Meiji', 'MEIJI',
                       'M', '45', '45', '45'
    end

    context 'on 1 January 1873 (Meiji 6)' do
      subject { described_class.new(1873, 1, 1) }
      include_examples '#era_name examples', '明治', 'Meiji'
      include_examples '#era_year examples', 6
      include_examples '#reiwa? examples', false
      include_examples '#heisei? examples', false
      include_examples '#showa? examples', false
      include_examples '#taisho? examples', false
      include_examples '#meiji? examples', true
      include_examples '#strftime examples', '明治', '明', 'Meiji', 'MEIJI',
                       'M', '06', '6', ' 6'
    end

    context 'before 1 January 1873 (Meiji 6)' do
      subject { described_class.new(1872, 12, 31) }

      context '#era_name' do
        it 'raises an error' do
          expect do
            subject.era_name
          end.to raise_error(RuntimeError)
            .with_message("#{described_class.name.downcase} out of range")
        end
      end

      context '#era_year' do
        it 'raises an error' do
          expect do
            subject.era_year
          end.to raise_error(RuntimeError)
            .with_message("#{described_class.name.downcase} out of range")
        end
      end

      include_examples '#reiwa? examples', false
      include_examples '#heisei? examples', false
      include_examples '#showa? examples', false
      include_examples '#taisho? examples', false
      include_examples '#meiji? examples', false
    end
  end

  describe Date do
    it_behaves_like 'an era'
  end

  describe DateTime do
    it_behaves_like 'an era'
  end

  describe Time do
    it_behaves_like 'an era'
  end
end
