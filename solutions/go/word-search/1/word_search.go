package wordsearch

import "errors"

var errWordNotFound = errors.New("one or more words were not found")

var directions = [8][2]int{
	{1, 0}, {-1, 0}, {0, 1}, {0, -1},
	{1, 1}, {-1, -1}, {-1, 1}, {1, -1},
}

// Solve locates each requested word in any horizontal, vertical, or diagonal direction.
func Solve(words []string, puzzle []string) (map[string][2][2]int, error) {
	locations := make(map[string][2][2]int, len(words))
	notFound := false
	for _, word := range words {
		start, end, ok := findWord(word, puzzle)
		if !ok {
			locations[word] = [2][2]int{{-1, -1}, {-1, -1}}
			notFound = true
			continue
		}
		locations[word] = [2][2]int{start, end}
	}
	if notFound {
		return locations, errWordNotFound
	}
	return locations, nil
}

func findWord(word string, puzzle []string) ([2]int, [2]int, bool) {
	if len(word) == 0 {
		return [2]int{}, [2]int{}, false
	}
	for y, row := range puzzle {
		for x := range row {
			for _, direction := range directions {
				endX, endY := x+(len(word)-1)*direction[0], y+(len(word)-1)*direction[1]
				if endY < 0 || endY >= len(puzzle) || endX < 0 || endX >= len(puzzle[endY]) {
					continue
				}

				matches := true
				for offset := range len(word) {
					currentX := x + offset*direction[0]
					currentY := y + offset*direction[1]
					if currentY < 0 || currentY >= len(puzzle) || currentX < 0 || currentX >= len(puzzle[currentY]) ||
						puzzle[currentY][currentX] != word[offset] {
						matches = false
						break
					}
				}
				if matches {
					return [2]int{x, y}, [2]int{endX, endY}, true
				}
			}
		}
	}
	return [2]int{}, [2]int{}, false
}
