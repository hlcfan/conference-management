require_relative '../talk_list'
require_relative '../arranger'
require 'pry'

describe Arranger do
  talks = {
    "Writing Fast Tests Against Enterprise Rails" => 60,
    "Overdoing it in Python"                      => 45,
    "Lua for the Masses"                          => 30,
    "Ruby Errors from Mismatched Gem Versions"    => 45,
    "Common Ruby Errors"                          => 45,
    "Rails for Python Developers lightning"       => 5,
    "Communicating Over Distance"                 => 60,
    "Accounting Driven Development"               => 45,
    "Woah"                                        => 30,
    "Sit Down and Write"                          => 30,
    "Pair Programming vs Noise"                   => 45,
    "Rails Magic"                                 => 60,
    "Ruby on Rails: Why We Should Move On"        => 60,
    "Clojure Ate Scala (on my project)"           => 45,
    "Programming in the Boondocks of Seattle"     => 30,
    "Ruby vs. Clojure for Back End Development"   => 30,
    "Ruby on Rails Legacy App Maintenance"        => 60,
    "A World Without HackerNews"                  => 30,
    "User Interface CSS in Rails Apps"            => 30,
  }

  subject(:arranger) { Arranger.new(talks: TalkList.new(talks)) }

  describe "#initialize" do
    it "initializes with talks and sets tracks length" do
      expect(arranger.tracks_count).to eq(2)
    end
  end

  describe "#output" do
    it "outputs organized talks with Lunch and Networking Event info" do
      renderer = double(:renderer, :render => "text")
      expect(renderer).to receive(:render).once
      arranger.output renderer
    end
  end

  describe "#arrange" do
    it "arrange organized talks" do
      tracks = arranger.send(:arrange)
      tracks.each do |track|
        expect( track[0].talks.map(&:length).inject(&:+) ).to eq(180)
        expect( track[1].talks.map(&:length).inject(&:+) ).to be > 180
        expect( track[1].talks.map(&:length).inject(&:+) ).to be < 240
      end
    end
  end
end
