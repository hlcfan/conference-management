require_relative 'talk'

class TalkList
  attr_reader :groups

  def initialize talks={}
    @talks = talks
    group_talks
  end

  def pop_longest
    return nil if @groups.empty?
    key = longest_talk_time
    value = @groups[key].delete_at 0
    # refactor with tap
    if @groups[key].length == 0
      @groups.delete(key)
    end

    value
  end

  def total_time
    @talks.values.inject(&:+)
  end

  def empty?
    @groups.empty?
  end

  def append talk
    @groups[talk.length] ||= []
    @groups[talk.length] << talk
  end

  private

  def longest_talk_time
    groups.keys.max
  end

  def group_talks
    @groups ||= begin
                  talks = @talks.map{|title, length| Talk.new(title, length)}
                  Hash[talks.group_by(&:length).sort_by(&:first).reverse]
                end
  end
end
