class Knapsack
  def initialize(max_weight)
    @max_weight = max_weight
  end

  def max_value(items)
    dp = Array.new(@max_weight + 1, 0)
    items.each do |item|
      @max_weight.downto(item.weight) do |w|
        val = dp[w - item.weight] + item.value
        dp[w] = val if val > dp[w]
      end
    end
    dp[@max_weight]
  end
end
