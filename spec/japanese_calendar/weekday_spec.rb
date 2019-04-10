# frozen_string_literal: true

require 'spec_helper'

describe JapaneseCalendar::Weekday do
  shared_examples 'weekday examples' do |full_name, abbreviated_name|
    describe '#strftime' do
      context 'with "%JA" format' do
        it "returns \"#{full_name}\"" do
          expect(subject.strftime('%JA')).to eq(full_name)
        end
      end

      context 'with "%Ja" format' do
        it "returns \"#{abbreviated_name}\"" do
          expect(subject.strftime('%Ja')).to eq(abbreviated_name)
        end
      end

      context 'with "%Q" format', if: (described_class == Time) do
        it "returns \"#{full_name}\" with a warning" do
          expect do
            expect(subject.strftime('%Q')).to eq(full_name)
          end.to output(/%Q is deprecated. Please use %JA instead./).to_stderr
        end
      end

      context 'with "%q" format' do
        it "returns \"#{abbreviated_name}\" with a warning" do
          expect do
            expect(subject.strftime('%q')).to eq(abbreviated_name)
          end.to output(/%q is deprecated. Please use %Ja instead./)
            .to_stderr
        end
      end
    end
  end

  shared_examples 'a weekday' do
    context 'on Sunday' do
      subject { described_class.new(2016, 12, 11) }
      include_examples 'weekday examples', '日曜日', '日'
    end

    context 'on Monday' do
      subject { described_class.new(2016, 12, 12) }
      include_examples 'weekday examples', '月曜日', '月'
    end

    context 'on Tuesday' do
      subject { described_class.new(2016, 12, 13) }
      include_examples 'weekday examples', '火曜日', '火'
    end

    context 'on Wednesday' do
      subject { described_class.new(2016, 12, 14) }
      include_examples 'weekday examples', '水曜日', '水'
    end

    context 'on Thursday' do
      subject { described_class.new(2016, 12, 15) }
      include_examples 'weekday examples', '木曜日', '木'
    end

    context 'on Friday' do
      subject { described_class.new(2016, 12, 16) }
      include_examples 'weekday examples', '金曜日', '金'
    end

    context 'on Saturday' do
      subject { described_class.new(2016, 12, 17) }
      include_examples 'weekday examples', '土曜日', '土'
    end
  end

  describe Date do
    it_behaves_like 'a weekday'
  end

  describe DateTime do
    it_behaves_like 'a weekday'
  end

  describe Time do
    it_behaves_like 'a weekday'
  end
end
