class Clock
  def initialize(hour: 0, minute: 0)
    @minutes = (hour * 60 + minute) % (24 * 60)
  end

  def to_s
    "%02d:%02d" % [@minutes / 60, @minutes % 60]
  end

  def +(other)
    Clock.new(minute: @minutes + other.minutes)
  end

  def -(other)
    Clock.new(minute: @minutes - other.minutes)
  end

  def ==(other)
    self.to_s == other.to_s
  end

  protected
  attr_reader :minutes
end
