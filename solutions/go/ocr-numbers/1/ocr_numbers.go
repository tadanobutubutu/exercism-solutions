package ocrnumbers

import (
	"errors"
	"strings"
)

var (
	errLineCount   = errors.New("number of input lines is not a multiple of four")
	errColumnCount = errors.New("number of input columns is not a multiple of three")
)

var digits = map[string]byte{
	" _ \n| |\n|_|\n   ": '0',
	"   \n  |\n  |\n   ": '1',
	" _ \n _|\n|_ \n   ": '2',
	" _ \n _|\n _|\n   ": '3',
	"   \n|_|\n  |\n   ": '4',
	" _ \n|_ \n _|\n   ": '5',
	" _ \n|_ \n|_|\n   ": '6',
	" _ \n  |\n  |\n   ": '7',
	" _ \n|_|\n|_|\n   ": '8',
	" _ \n|_|\n _|\n   ": '9',
}

// Recognize converts rows of seven-segment-style digits into decimal strings.
func Recognize(input string) ([]string, error) {
	input = strings.ReplaceAll(input, "\r\n", "\n")
	lines := strings.Split(input, "\n")
	if len(lines) > 0 && lines[0] == "" {
		lines = lines[1:]
	}
	if len(lines)%4 != 0 {
		return nil, errLineCount
	}
	if len(lines) == 0 {
		return []string{}, nil
	}

	width := len(lines[0])
	if width%3 != 0 {
		return nil, errColumnCount
	}
	for _, line := range lines[1:] {
		if len(line)%3 != 0 || len(line) != width {
			return nil, errColumnCount
		}
	}

	results := make([]string, 0, len(lines)/4)
	for row := 0; row < len(lines); row += 4 {
		var output strings.Builder
		for col := 0; col < width; col += 3 {
			cell := strings.Join([]string{
				lines[row][col : col+3],
				lines[row+1][col : col+3],
				lines[row+2][col : col+3],
				lines[row+3][col : col+3],
			}, "\n")
			if digit, ok := digits[cell]; ok {
				output.WriteByte(digit)
			} else {
				output.WriteByte('?')
			}
		}
		results = append(results, output.String())
	}
	return results, nil
}
