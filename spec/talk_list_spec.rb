require_relative '../talk_list'
require 'pry'

RSpec.describe TalkList do
  talks = {
    "Writing Fast Tests Against Enterprise Rails" => 60,
    "Overdoing it in Python"                      => 45,
    "Lua for the Masses"                          => 30,
    "Ruby Errors from Mismatched Gem Versions"    => 45,
  }
  subject(:talk_list) { TalkList.new(talks) }

  describe "#initialize" do
    it "groups talks by duration" do
      expect(talk_list.groups.keys).to eq(talks.values.uniq)
    end
  end

  describe "#pop_longest" do
    it "pops longest talk" do
      talk = talk_list.pop_longest
      expect(talk.length).to eq(60)
      expect(talk_list.groups[60]).to be_nil
    end
  end

  describe "#total_time" do
    it "returns total time of talks" do
      expect(talk_list.total_time).to eq(talks.values.inject(&:+))
    end
  end

  describe "#empty?" do
    it "returns false if any talks" do
      expect(talk_list.empty?).to be(false)
    end

    it "returns true if empty talks" do
      expect(TalkList.new.empty?).to be(true)
    end
  end


end
