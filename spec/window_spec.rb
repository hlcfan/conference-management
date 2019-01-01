require_relative '../window'
require_relative '../talk'
require 'pry'

RSpec.describe Window do
  subject(:window) { Window.new }
  describe "#initialize" do
    it "sets talks to empty and size to zero" do
      expect(window.talks).to be_empty
      expect(window.size).to eq(0)
    end
  end

  describe "#append" do
    it "appends new item" do
      window.append(Talk.new("Rails session", 30))
      expect(window.size).to eq(30)
    end
  end

  describe "#pop" do
    it "pops an item" do
      talk = Talk.new("Rails session", 30)
      window.append(talk)
      expect(window.size).to eq(30)
      pop_talk = window.pop
      expect(window.size).to eq(0)
      expect(pop_talk).to eq(talk)
    end

    it "doesn't change window size if nothing to pop" do
      talk = window.pop
      expect(window.size).to eq(0)
      expect(talk).to be_nil
    end
  end

  describe "#random_pop" do
    it "randomly pops an item" do
      talk_1 = Talk.new("Rails session", 30)
      talk_2 = Talk.new("Swift introduction", 40)
      talk_3 = Talk.new("Go and micro-services", 60)
      window.append(talk_1)
      window.append(talk_2)
      window.append(talk_3)
      allow(Random).to receive(:rand) { 1 }
      talk = window.random_pop
      expect(talk).to eq(talk_2)
    end
  end

  describe "#print" do
    it "returns talks with timestamp by given time" do
      talk_1 = Talk.new("Rails session", 30)
      talk_2 = Talk.new("Swift introduction", 40)
      talk_3 = Talk.new("Go and micro-services", 60)
      window.append(talk_1)
      window.append(talk_2)
      window.append(talk_3)
      now = Time.now
      time = Time.new(now.year, now.month, now.day, 9, 0, 0)
      window.print( time ) do |output|
        expect(output).to eq(["09:00AM Rails session 30", "09:30AM Swift introduction 40", "10:10AM Go and micro-services 60"])
      end
    end
  end

  describe "#delete_if" do
    it "delegates delete_if to talks and reset size" do
      talk = Talk.new("Go and micro-services", 60)
      window.delete_if{ |t| talk.title.includes?("micro-services") }
      expect(window.size).to eq(0)
    end
  end
end
