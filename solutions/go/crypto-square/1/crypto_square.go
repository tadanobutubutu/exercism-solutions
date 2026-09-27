package cryptosquare

import (
	"strings"
	"unicode"
)

func Encode(pt string) string {
	var normalized []rune
	for _, r := range pt {
		if unicode.IsLetter(r) || unicode.IsDigit(r) {
			normalized = append(normalized, unicode.ToLower(r))
		}
	}
	if len(normalized) == 0 {
		return ""
	}

	columns := 1
	for columns*columns < len(normalized) {
		columns++
	}
	rows := (len(normalized) + columns - 1) / columns
	if columns-rows > 1 {
		rows++
	}

	var encoded strings.Builder
	for column := 0; column < columns; column++ {
		if column > 0 {
			encoded.WriteByte(' ')
		}
		for row := 0; row < rows; row++ {
			index := row*columns + column
			if index < len(normalized) {
				encoded.WriteRune(normalized[index])
			} else {
				encoded.WriteByte(' ')
			}
		}
	}
	return encoded.String()
}
