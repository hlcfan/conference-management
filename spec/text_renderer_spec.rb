require_relative '../text_renderer'
require_relative '../talk_list'
require_relative '../window180'
require_relative '../window240'
require 'pry'

RSpec.describe TextRenderer do
  describe ".render" do
    it "renders tracks" do
      talks = {
        "talk 1" => 60,
        "talk 2" => 60,
        "talk 3" => 60,
        "talk 4" => 45,
        "talk 5" => 45,
        "talk 6" => 45,
        "talk 7" => 45,
        "talk 8" => 30
      }.map do |title, length|
        Talk.new(title, length)
      end

      morning_session = Window180.new
      afternoon_session = Window240.new

      talks[0..2].each { |t| morning_session.append(t) }
      talks[3..7].each { |t| afternoon_session.append(t) }

      expect(STDOUT).to receive(:puts) {
        <<-PUTS
        Track 1
        09:00AM talk 1 60
        10:00AM talk 2 60
        11:00AM talk 3 60
        12:00AM Lunch 60min
        01:00PM talk 4 45
        01:45PM talk 5 45
        02:30PM talk 6 45
        03:15PM talk 7 45
        04:00PM talk 8 30
        04:30PM Networking Event
        PUTS
      }

      text = TextRenderer.render([[morning_session, afternoon_session]])
    end
  end
end
