require_relative 'talk_list'
require_relative 'arranger'
require_relative 'text_renderer'
require 'csv'
require 'pry'

file_path = ARGV.first
if File.exist?(file_path)
  talks = {}
  CSV.foreach(file_path) do |row|
    talks[row.first] = row.last.to_i
  end
  arranger = Arranger.new talks: TalkList.new(talks)
  arranger.output(TextRenderer)
else
  puts "File #{file_path} not exist!"
end
