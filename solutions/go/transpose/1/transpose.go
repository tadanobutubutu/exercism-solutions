package transpose

func Transpose(input []string) []string {
	rows := make([][]rune, len(input))
	maxWidth := 0
	for i, line := range input {
		rows[i] = []rune(line)
		if len(rows[i]) > maxWidth {
			maxWidth = len(rows[i])
		}
	}

	result := make([]string, 0, maxWidth)
	for col := 0; col < maxWidth; col++ {
		lastRow := -1
		for row := range rows {
			if col < len(rows[row]) {
				lastRow = row
			}
		}
		transposed := make([]rune, lastRow+1)
		for row := 0; row <= lastRow; row++ {
			if col < len(rows[row]) {
				transposed[row] = rows[row][col]
			} else {
				transposed[row] = ' '
			}
		}
		result = append(result, string(transposed))
	}
	return result
}
