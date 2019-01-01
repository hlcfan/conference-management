require_relative 'window180'
require_relative 'window240'

class Arranger
  attr_reader :tracks_count

  def initialize talks: {}
    @talks = talks
    @tracks_count = (@talks.total_time / 420.to_f).ceil
  end

  def output render
    render.render(arrange)
  end

  private

  def windows
    @windows ||= begin
      windows = []
      @tracks_count.times { windows << Window180.new }
      @tracks_count.times { windows << Window240.new }

      windows
    end
  end

  def arrange
    @temp_talks = []

    until @talks.empty? do
      windows.each do |window|
        talk = @talks.pop_longest
        if talk
          if window.appendable?(talk.length)
            window.append(talk)
          else
            @talks.append(window.random_pop)
            @talks.append(talk)
          end
        end
      end
    end

    windows.select{|w| Window180 === w}.each do |window|
      unless window.satisfied?
        find_and_switch_talks window, windows.select{|w| Window240 === w}
      end
    end

    morning, afternoon = windows.each_slice(@tracks_count).to_a
    tracks = morning.zip afternoon
  end

  def find_and_switch_talks window, other_windows
    target = window.length - window.size
    find_stage = nil
    found = nil
    other_windows.each_with_index do |other_window, index|
      found = find_talks(other_window.talks, target)
      if !found.nil?
        find_stage = index
        break
      end
    end

    if found.nil?
      @temp_talks << window.pop
      find_and_switch_talks window, other_windows
    else
      found.each {|talk| window.append(talk)}
      other_windows[find_stage].delete_if {|talk| found.map(&:title).include?(talk.title)}
      @temp_talks.each do |talk|
        if other_windows[find_stage].appendable?(talk.length)
          other_windows[find_stage].append(talk)
        end
      end

      return found
    end
  end

  def find_talks talks, target
    h = Hash.new { |h, k| h[k] = [] }
    
    talks.each do |talk|
      complement = target - talk.length
      if h.key?(complement)
        return [talk, h[complement]]
      else
        h[talk.length] = talk
      end
    end
    nil
  end
end
