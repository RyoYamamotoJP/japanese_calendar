require "spec_helper"

describe JapaneseCalendar::Era do
  describe "#era_name" do
    context "in the Heisei period" do
      it 'returns "平成"' do
        expect(Time.new(1989, 1, 8).era_name).to eq("平成")
      end
    end

    context "in the Showa period" do
      it 'returns "昭和"' do
        expect(Time.new(1989,  1,  7, 23, 59, 59).era_name).to eq("昭和")
        expect(Time.new(1926, 12, 25,  0,  0,  0).era_name).to eq("昭和")
      end
    end

    context "in the Taisho period" do
      it 'returns "大正"' do
        expect(Time.new(1926, 12, 24, 23, 59, 59).era_name).to eq("大正")
        expect(Time.new(1912,  7, 30,  0,  0,  0).era_name).to eq("大正")
      end
    end

    context "in the Meiji period" do
      it 'returns "明治"' do
        expect(Time.new(1912,  7, 29, 23, 59, 59).era_name).to eq("明治")
        expect(Time.new(1868,  1, 25,  0,  0,  0).era_name).to eq("明治")
      end
    end

    context "before the Meiji period" do
      it "raises an error" do
        expect do
          Time.new(1868,  1, 24, 23, 59, 59).era_name
        end.to raise_error(RuntimeError, "time out of range")
      end
    end
  end

  describe "#era_year" do
    context "on the first day of the Heisei period" do
      it "returns 1" do
        expect(Time.new(1989, 1, 8).era_year).to eq(1)
      end
    end

    context "on the last day of the Showa period" do
      it "returns 64" do
        expect(Time.new(1989, 1, 7).era_year).to eq(64)
      end
    end

    context "on the first day of the Showa period" do
      it "returns 1" do
        expect(Time.new(1926, 12, 25).era_year).to eq(1)
      end
    end

    context "on the last day of the Taisho period" do
      it "returns 15" do
        expect(Time.new(1926, 12, 24).era_year).to eq(15)
      end
    end

    context "on the first day of the Taisho period" do
      it "returns 1" do
        expect(Time.new(1912, 7, 30).era_year).to eq(1)
      end
    end

    context "on the last day of the Meiji period" do
      it "returns 45" do
        expect(Time.new(1912, 7, 29).era_year).to eq(45)
      end
    end

    context "on the first day of the Meiji period" do
      it "returns 1" do
        expect(Time.new(1868, 1, 25).era_year).to eq(1)
      end
    end

    context "before the Meiji period" do
      it "raises an error" do
        expect do
          Time.new(1868, 1, 24).era_year
        end.to raise_error(RuntimeError, "time out of range")
      end
    end
  end
end
