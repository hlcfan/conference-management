require_relative 'window'

class Window180 < Window

  def length
    180
  end

  def appendable? talk_time
    @size + talk_time <= length
  end

  def morning?
    true
  end

  def satisfied?
    true if @size == length
  end
end
