package bookstore

import "math/bits"

func Cost(books []int) int {
	counts := [5]int{}
	for _, book := range books {
		if book >= 1 && book <= 5 {
			counts[book-1]++
		}
	}
	groupCost := [...]int{0, 800, 1520, 2160, 2560, 3000}
	memo := make(map[[5]int]int)
	var cheapest func([5]int) int
	cheapest = func(remaining [5]int) int {
		if price, exists := memo[remaining]; exists {
			return price
		}
		empty := true
		for _, count := range remaining {
			if count > 0 {
				empty = false
				break
			}
		}
		if empty {
			return 0
		}

		best := int(^uint(0) >> 1)
		for subset := 1; subset < 1<<5; subset++ {
			size := bits.OnesCount(uint(subset))
			if size >= best {
				continue
			}
			next := remaining
			possible := true
			for book := 0; book < 5; book++ {
				if subset&(1<<book) != 0 {
					if next[book] == 0 {
						possible = false
						break
					}
					next[book]--
				}
			}
			if !possible {
				continue
			}
			price := groupCost[size] + cheapest(next)
			if price < best {
				best = price
			}
		}
		memo[remaining] = best
		return best
	}
	return cheapest(counts)
}
