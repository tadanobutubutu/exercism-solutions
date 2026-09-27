package knapsack

type Item struct {
	Weight, Value int
}

// Knapsack takes in a maximum carrying capacity and a collection of items
// and returns the maximum value that can be carried by the knapsack
// given that the knapsack can only carry a maximum weight given by maximumWeight
func Knapsack(maximumWeight int, items []Item) int {
	if maximumWeight <= 0 {
		return 0
	}
	best := make([]int, maximumWeight+1)
	for _, item := range items {
		if item.Weight <= 0 || item.Weight > maximumWeight {
			continue
		}
		for capacity := maximumWeight; capacity >= item.Weight; capacity-- {
			value := best[capacity-item.Weight] + item.Value
			if value > best[capacity] {
				best[capacity] = value
			}
		}
	}
	return best[maximumWeight]
}
