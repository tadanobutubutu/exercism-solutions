package killersudokuhelper

// Combinations returns the sorted digit sets that can fill a killer cage.
func Combinations(sum, size int, exclude []int) [][]int {
	combinations := make([][]int, 0)
	if size < 0 || size > 9 {
		return combinations
	}

	var excluded [10]bool
	for _, digit := range exclude {
		if digit >= 1 && digit <= 9 {
			excluded[digit] = true
		}
	}

	current := make([]int, 0, size)
	var search func(nextDigit, remaining int)
	search = func(nextDigit, remaining int) {
		if len(current) == size {
			if remaining == 0 {
				combinations = append(combinations, append([]int{}, current...))
			}
			return
		}

		needed := size - len(current)
		available := make([]int, 0, 9)
		for digit := nextDigit; digit <= 9; digit++ {
			if !excluded[digit] {
				available = append(available, digit)
			}
		}
		if len(available) < needed {
			return
		}
		minPossible, maxPossible := 0, 0
		for i := 0; i < needed; i++ {
			minPossible += available[i]
			maxPossible += available[len(available)-1-i]
		}
		if remaining < minPossible || remaining > maxPossible {
			return
		}

		for digit := nextDigit; digit <= 9; digit++ {
			if excluded[digit] {
				continue
			}
			current = append(current, digit)
			search(digit+1, remaining-digit)
			current = current[:len(current)-1]
		}
	}
	search(1, sum)
	return combinations
}
