package gameoflife

func Tick(matrix [][]int) [][]int {
	next := make([][]int, len(matrix))
	for row, cells := range matrix {
		next[row] = make([]int, len(cells))
		for col, cell := range cells {
			neighbors := 0
			for dr := -1; dr <= 1; dr++ {
				for dc := -1; dc <= 1; dc++ {
					if dr == 0 && dc == 0 {
						continue
					}
					r, c := row+dr, col+dc
					if r >= 0 && r < len(matrix) && c >= 0 && c < len(matrix[r]) && matrix[r][c] == 1 {
						neighbors++
					}
				}
			}
			if (cell == 1 && (neighbors == 2 || neighbors == 3)) || (cell == 0 && neighbors == 3) {
				next[row][col] = 1
			}
		}
	}
	return next
}
