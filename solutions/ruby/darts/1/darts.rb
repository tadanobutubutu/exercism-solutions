class Darts
  def initialize(x, y)
    @distance = Math.sqrt(x * x + y * y)
  end

  def score
    if @distance <= 1 then 10
    elsif @distance <= 5 then 5
    elsif @distance <= 10 then 1
    else 0
    end
  end
end
