# frozen_string_literal: true

require "spec_helper"

describe JapaneseCalendar::Weekday do
  shared_examples "a weekday" do |weekday|
    describe "#strftime" do
      context "with %JA format" do
        let(:format) { "%JA" }

        it "returns \"#{weekday}\"" do
          expect(subject.strftime(format)).to eq(weekday)
        end
      end

      context "with %Ja format" do
        let(:format) { "%Ja" }

        it "returns \"#{weekday[0]}\"" do
          expect(subject.strftime(format)).to eq(weekday[0])
        end
      end

      context "with %Q format" do
        let(:format) { "%Q" }

        it "returns \"#{weekday}\" with a warning" do
          expect(subject.strftime(format)).to eq(weekday)
          expect do
            subject.strftime(format)
          end.to output(/%Q is deprecated. Please use %JA instead./).to_stderr
        end
      end

      context "with %q format" do
        let(:format) { "%q" }

        it "returns \"#{weekday[0]}\" with a warning" do
          expect(subject.strftime(format)).to eq(weekday[0])
          expect do
            subject.strftime(format)
          end.to output(/%q is deprecated. Please use %Ja instead./).to_stderr
        end
      end
    end
  end

  context "on Sunday" do
    subject { Time.new(2016, 12, 11) }
    it_behaves_like "a weekday", "日曜日"
  end

  context "on Monday" do
    subject { Time.new(2016, 12, 12) }
    it_behaves_like "a weekday", "月曜日"
  end

  context "on Tuesday" do
    subject { Time.new(2016, 12, 13) }
    it_behaves_like "a weekday", "火曜日"
  end

  context "on Wednesday" do
    subject { Time.new(2016, 12, 14) }
    it_behaves_like "a weekday", "水曜日"
  end

  context "on Thursday" do
    subject { Time.new(2016, 12, 15) }
    it_behaves_like "a weekday", "木曜日"
  end

  context "on Friday" do
    subject { Time.new(2016, 12, 16) }
    it_behaves_like "a weekday", "金曜日"
  end

  context "on Saturday" do
    subject { Time.new(2016, 12, 17) }
    it_behaves_like "a weekday", "土曜日"
  end
end
