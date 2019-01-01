class TextRenderer
  def self.render tracks
    tracks.each_with_index do |track, index|
      puts "Track #{index+1}"
      @current_time = track.first.print current_time
      puts "12:00AM Lunch 60min"
      @current_time += 60 * 60
      @current_time = track.last.print current_time
      puts "#{@current_time.strftime("%I:%M%p")} Networking Event"
      puts
      @current_time = nil
    end
  end

  def self.current_time
    @current_time ||= begin
                        now = Time.now
                        Time.new(now.year, now.month, now.day, 9, 0, 0)
                      end
  end

  private_class_method :current_time
end
