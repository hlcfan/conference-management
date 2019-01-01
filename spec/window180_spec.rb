require_relative '../window180'
require_relative '../talk'
require 'pry'

describe Window180 do
  subject(:window) { Window180.new }

  describe "#length" do
    it "equals 180" do
      expect(window.length).to eq(180)
    end
  end

  describe "#appendable?" do
    it "returns true if talk time is qualified" do
      expect(window.appendable?(60)).to be(true)
    end

    it "returns false if talk time is not qualified" do
      window.append(Talk.new("Whatev", 180))
      expect(window.appendable?(60)).to be(false)
    end
  end

  describe "#morning?" do
    it "returns true" do
      expect(window.morning?).to be(true)
    end
  end

  describe "#satisfied?" do
    it "returns true if window size equals length" do
      window.append(Talk.new("Whatev", 180))
      expect(window.satisfied?).to be(true)
    end

    it "returns falsy if window size doesn't equals length" do
      window.append(Talk.new("Whatev", 80))
      expect(window.satisfied?).to be_falsy
    end
  end


end
