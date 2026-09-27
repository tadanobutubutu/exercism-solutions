// Package acronym creates initialisms from phrases.
package acronym

import (
	"strings"
	"unicode"
)

// Abbreviate returns the uppercase initials of the words in s.
func Abbreviate(s string) string {
	letters := []rune(s)
	var acronym strings.Builder
	inWord := false
	for index, character := range letters {
		if unicode.IsLetter(character) || unicode.IsDigit(character) {
			if !inWord {
				acronym.WriteRune(unicode.ToUpper(character))
			}
			inWord = true
			continue
		}
		if character == '\'' && inWord && index+1 < len(letters) &&
			(unicode.IsLetter(letters[index+1]) || unicode.IsDigit(letters[index+1])) {
			continue
		}
		inWord = false
	}
	return acronym.String()
}
