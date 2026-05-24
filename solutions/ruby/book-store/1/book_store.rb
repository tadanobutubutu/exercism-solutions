class BookStore
  DISCOUNTS = [0, 0, 0.05, 0.10, 0.20, 0.25]

  def self.calculate_price(basket)
    groups = []
    counts = Array.new(5, 0)
    basket.each { |b| counts[b - 1] += 1 }

    while counts.any? { |c| c > 0 }
      group = (0...5).select { |i| counts[i] > 0 }
      group.each { |i| counts[i] -= 1 }
      groups << group.length
    end

    optimize(groups)
  end

  def self.optimize(groups)
    while groups.include?(5) && groups.include?(3)
      groups[groups.index(5)] = 4
      groups[groups.index(3)] = 4
    end

    groups.sum { |n| n * 8 * (1 - DISCOUNTS[n]) }
  end
end
