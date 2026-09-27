package flowerfield

// Annotate returns an annotated board
func Annotate(board []string) []string {
	if len(board) == 0 {
		return []string{}
	}
	rows := len(board)
	annotated := make([]string, rows)
	for row := 0; row < rows; row++ {
		cells := []byte(board[row])
		for col := 0; col < len(cells); col++ {
			if cells[col] == '*' {
				continue
			}
			flowers := 0
			for dr := -1; dr <= 1; dr++ {
				for dc := -1; dc <= 1; dc++ {
					if dr == 0 && dc == 0 {
						continue
					}
					nr, nc := row+dr, col+dc
					if nr >= 0 && nr < rows && nc >= 0 && nc < len(board[nr]) && board[nr][nc] == '*' {
						flowers++
					}
				}
			}
			if flowers > 0 {
				cells[col] = byte('0' + flowers)
			}
		}
		annotated[row] = string(cells)
	}
	return annotated
}
