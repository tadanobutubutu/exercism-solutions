class Prime
  def self.nth(n)
    raise ArgumentError if n < 1
    primes = []
    candidate = 2
    while primes.length < n
      primes << candidate if primes.all? { |p| candidate % p != 0 }
      candidate += 1
    end
    primes.last
  end
end
