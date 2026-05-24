class SumOfMultiples
  def initialize(*factors)
    @factors = factors
  end

  def to(limit)
    (1...limit).select do |n|
      @factors.any? { |f| f != 0 && n % f == 0 }
    end.sum
  end
end
