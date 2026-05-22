class PythagoreanTriplet
  def self.triplets_with_sum(sum)
    triplets = []
    # a < b < c
    # a^2 + b^2 = c^2
    # a + b + c = sum
    # => c = sum - a - b
    # a^2 + b^2 = (sum - a - b)^2
    # a^2 + b^2 = sum^2 + a^2 + b^2 - 2*sum*a - 2*sum*b + 2*a*b
    # 0 = sum^2 - 2*sum*a - 2*sum*b + 2*a*b
    # 2*sum*b - 2*a*b = sum^2 - 2*sum*a
    # b = (sum^2 - 2*sum*a) / (2*sum - 2*a)
    
    for a in 1..(sum / 3)
      b_numerator = sum**2 - 2 * sum * a
      b_denominator = 2 * sum - 2 * a
      if b_numerator % b_denominator == 0
        b = b_numerator / b_denominator
        c = sum - a - b
        if a < b && b < c
          triplets << [a, b, c]
        end
      end
    end
    triplets
  end
end
