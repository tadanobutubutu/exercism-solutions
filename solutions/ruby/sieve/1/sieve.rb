class Sieve
  def initialize(limit)
    @limit = limit
  end

  def primes
    return [] if @limit < 2
    sieve = [true] * (@limit + 1)
    sieve[0] = false
    sieve[1] = false
    (2..Math.sqrt(@limit)).each do |i|
      if sieve[i]
        (i * i..@limit).step(i) { |j| sieve[j] = false }
      end
    end
    sieve.each_index.select { |i| sieve[i] }
  end
end
