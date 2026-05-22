class AssemblyLine
  CARS_PER_SPEED = 221

  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    rate = @speed * CARS_PER_SPEED
    case @speed
    when 1..4
      rate * 1.0
    when 5..8
      rate * 0.9
    when 9
      rate * 0.8
    when 10
      rate * 0.77
    else
      0
    end
  end

  def working_items_per_minute
    (production_rate_per_hour / 60).to_i
  end
end
