package diamond

import (
	"errors"
	"strings"
)

func Gen(char byte) (string, error) {
	if char < 'A' || char > 'Z' {
		return "", errors.New("input must be an uppercase letter")
	}

	middle := int(char - 'A')
	width := 2*middle + 1
	rows := make([]string, width)
	for row := 0; row < width; row++ {
		letterIndex := row
		if row > middle {
			letterIndex = width - 1 - row
		}
		padding := middle - letterIndex
		var line strings.Builder
		line.WriteString(strings.Repeat(" ", padding))
		letter := byte('A' + letterIndex)
		line.WriteByte(letter)
		if letterIndex > 0 {
			line.WriteString(strings.Repeat(" ", 2*letterIndex-1))
			line.WriteByte(letter)
		}
		line.WriteString(strings.Repeat(" ", padding))
		rows[row] = line.String()
	}
	return strings.Join(rows, "\n"), nil
}
