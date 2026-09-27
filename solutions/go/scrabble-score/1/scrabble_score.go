package scrabblescore

import "unicode"

func Score(word string) int {
	score := 0
	for _, letter := range word {
		switch unicode.ToLower(letter) {
		case 'a', 'e', 'i', 'l', 'n', 'o', 'r', 's', 't', 'u':
			score += 1
		case 'd', 'g':
			score += 2
		case 'b', 'c', 'm', 'p':
			score += 3
		case 'f', 'h', 'v', 'w', 'y':
			score += 4
		case 'k':
			score += 5
		case 'j', 'x':
			score += 8
		case 'q', 'z':
			score += 10
		}
	}
	return score
}
