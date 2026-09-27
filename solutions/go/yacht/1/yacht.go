package yacht

import "strings"

func Score(dice []int, category string) int {
	counts := [7]int{}
	total := 0
	for _, die := range dice {
		if die < 1 || die > 6 {
			return 0
		}
		counts[die]++
		total += die
	}
	category = strings.ToLower(strings.TrimSpace(category))

	switch category {
	case "ones", "twos", "threes", "fours", "fives", "sixes":
		value := 1
		switch category {
		case "twos":
			value = 2
		case "threes":
			value = 3
		case "fours":
			value = 4
		case "fives":
			value = 5
		case "sixes":
			value = 6
		}
		return value * counts[value]
	case "full house":
		hasPair, hasTriple := false, false
		for value := 1; value <= 6; value++ {
			hasPair = hasPair || counts[value] == 2
			hasTriple = hasTriple || counts[value] == 3
		}
		if hasPair && hasTriple {
			return total
		}
	case "four of a kind":
		for value := 1; value <= 6; value++ {
			if counts[value] >= 4 {
				return value * 4
			}
		}
	case "little straight":
		if counts[1] == 1 && counts[2] == 1 && counts[3] == 1 && counts[4] == 1 && counts[5] == 1 {
			return 30
		}
	case "big straight":
		if counts[2] == 1 && counts[3] == 1 && counts[4] == 1 && counts[5] == 1 && counts[6] == 1 {
			return 30
		}
	case "choice":
		return total
	case "yacht":
		for value := 1; value <= 6; value++ {
			if counts[value] == 5 {
				return 50
			}
		}
	}
	return 0
}
