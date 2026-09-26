class Knapsack
  def initialize(max_weight)
    @max_weight = max_weight
  end

  def max_value(items)
    best_values = Array.new(@max_weight + 1, 0)

    items.each do |item|
      @max_weight.downto(item.weight) do |weight|
        best_values[weight] = [best_values[weight], best_values[weight - item.weight] + item.value].max
      end
    end

    best_values[@max_weight]
  end
end
