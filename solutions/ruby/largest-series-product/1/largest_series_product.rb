class Series
  def initialize(digits)
    raise ArgumentError if digits.match?(/[^0-9]/)
    @digits = digits
  end

  def largest_product(span)
    raise ArgumentError if span > @digits.length || span < 0
    return 1 if span == 0
    max = 0
    (0..@digits.length - span).each do |i|
      product = @digits[i, span].chars.map(&:to_i).reduce(:*)
      max = product if product > max
    end
    max
  end
end
