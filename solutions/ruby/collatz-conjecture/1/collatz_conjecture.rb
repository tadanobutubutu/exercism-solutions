class CollatzConjecture
  def self.steps(n)
    raise ArgumentError if n < 1
    count = 0
    until n == 1
      n = n.even? ? n / 2 : 3 * n + 1
      count += 1
    end
    count
  end
end
