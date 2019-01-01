require_relative '../window240'
require_relative '../talk'
require 'pry'

RSpec.describe Window240 do
  subject(:window) { Window240.new }

  describe "#length" do
    it "equals 240" do
      expect(window.length).to eq(240)
    end
  end

  describe "#appendable?" do
    it "returns true if talk time is qualified" do
      expect(window.appendable?(60)).to be(true)
    end

    it "returns false if talk time is not qualified" do
      window.append(Talk.new("Whatev", 240))
      expect(window.appendable?(60)).to be(false)
    end
  end

  describe "#morning?" do
    it "returns false" do
      expect(window.morning?).to be(false)
    end
  end

  describe "#satisfied?" do
    it "returns true if window size less than length" do
      window.append(Talk.new("Whatev", 80))
      expect(window.satisfied?).to be(true)
    end

    it "returns falsy if window size greater than length" do
      window.append(Talk.new("Whatev", 240))
      expect(window.satisfied?).to be_falsy
    end
  end
end
