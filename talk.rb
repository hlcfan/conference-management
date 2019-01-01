class Talk
  attr_reader :title, :length

  private

  def initialize title, length
    @title = title
    @length = length
  end
end
