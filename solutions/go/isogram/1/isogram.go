package isogram

import (
	"strings"
	"unicode"
)

func IsIsogram(word string) bool {
	seen := make(map[rune]struct{})
	for _, character := range strings.ToLower(word) {
		if !unicode.IsLetter(character) {
			continue
		}
		if _, exists := seen[character]; exists {
			return false
		}
		seen[character] = struct{}{}
	}
	return true
}
