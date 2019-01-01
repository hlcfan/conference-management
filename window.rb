class Window
  attr_reader :talks, :size

  def initialize
    @talks = []
    @size = 0
  end

  def append talk
    @size += talk.length
    @talks << talk
  end

  def pop
    last = @talks.pop
    @size -= last.length unless last.nil?

    last
  end

  def random_pop
    random_item = @talks.delete_at(Random.rand(@talks.length))
    @size -= random_item.length unless random_item.nil?

    random_item
  end

  def print time
    @talks.each do |talk|
      puts "#{format_time(time)} #{talk.title} #{talk.length}"
      time += talk.length * 60
    end

    time
  end

  def delete_if &block
    talks.delete_if &block
    @size = get_size
  end

  private

  def format_time time
    time.strftime("%I:%M%p")
  end

  def get_size
    @talks.map(&:length).inject(&:+) || 0
  end

  protected

  def length
    raise StandardError, "Initialize window object from class Window180 or Window240!"
  end

  def appendable?
    false
  end

  def morning?
    false
  end

  def afternoon?
    false
  end

  def satisfied?
    false
  end

end
