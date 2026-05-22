class Clock
  MINUTES_IN_DAY = 24 * 60

  def initialize(hour: 0, minute: 0)
    @total = (hour * 60 + minute) % MINUTES_IN_DAY
  end

  def to_s
    format("%02d:%02d", @total / 60, @total % 60)
  end

  def +(other)
    Clock.new(minute: @total + other.instance_variable_get(:@total))
  end

  def -(other)
    Clock.new(minute: @total - other.instance_variable_get(:@total))
  end

  def ==(other)
    @total == other.instance_variable_get(:@total)
  end

  def hash
    @total.hash
  end

  alias eql? ==
end