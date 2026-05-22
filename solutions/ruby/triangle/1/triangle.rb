class Triangle
  def initialize(sides)
    @sides = sides
  end

  def equilateral?
    valid? && @sides.uniq.size == 1
  end

  def isosceles?
    valid? && @sides.uniq.size <= 2
  end

  def scalene?
    valid? && @sides.uniq.size == 3
  end

  private

  def valid?
    @sides.size == 3 &&
      @sides.all? { |s| s > 0 } &&
      @sides[0] + @sides[1] > @sides[2] &&
      @sides[0] + @sides[2] > @sides[1] &&
      @sides[1] + @sides[2] > @sides[0]
  end
end
