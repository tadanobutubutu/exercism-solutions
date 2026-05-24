class Palindromes
  attr_reader :smallest, :largest

  def initialize(max_factor:, min_factor: 1)
    @max_factor = max_factor
    @min_factor = min_factor
    raise ArgumentError, "min must be <= max" if min_factor > max_factor
  end

  def generate
    palindromes = Hash.new { |h, k| h[k] = [] }
    (@min_factor..@max_factor).each do |a|
      (a..@max_factor).each do |b|
        product = a * b
        if palindrome?(product)
          palindromes[product] << [a, b]
        end
      end
    end
    smallest_val = palindromes.keys.min
    largest_val = palindromes.keys.max
    @smallest = Palindrome.new(smallest_val, palindromes[smallest_val] || [])
    @largest = Palindrome.new(largest_val, palindromes[largest_val] || [])
  end

  def palindrome?(n)
    s = n.to_s
    s == s.reverse
  end
end

class Palindrome
  attr_reader :value, :factors

  def initialize(value, factors)
    @value = value
    @factors = factors
  end
end
