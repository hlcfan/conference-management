require_relative 'window'

class Window240 < Window
  def length
    240
  end

  def appendable? talk_time
    @size + talk_time < length
  end

  def morning?
    false
  end

  def satisfied?
    true if @size < length
  end
end
