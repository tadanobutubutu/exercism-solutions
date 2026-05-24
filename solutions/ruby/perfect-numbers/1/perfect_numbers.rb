class PerfectNumber
  def self.classify(n)
    raise ArgumentError, "Classification is only possible for positive integers." if n < 1
    sum = (1...n).select { |i| n % i == 0 }.sum
    if sum == n then 'perfect'
    elsif sum > n then 'abundant'
    else 'deficient'
    end
  end
end
