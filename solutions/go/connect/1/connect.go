package connect

import "strings"

func ResultOf(lines []string) (string, error) {
	board := make([][]string, len(lines))
	for row, line := range lines {
		board[row] = strings.Fields(line)
	}
	if hasConnection(board, "X") {
		return "X", nil
	}
	if hasConnection(board, "O") {
		return "O", nil
	}
	return "", nil
}

func hasConnection(board [][]string, player string) bool {
	if len(board) == 0 {
		return false
	}
	type point struct{ row, column int }
	queue := make([]point, 0)
	seen := make(map[point]bool)
	for row, cells := range board {
		for column, cell := range cells {
			starts := player == "X" && column == 0 || player == "O" && row == 0
			if cell == player && starts {
				p := point{row, column}
				queue = append(queue, p)
				seen[p] = true
			}
		}
	}
	for len(queue) > 0 {
		current := queue[0]
		queue = queue[1:]
		if player == "X" && current.column == len(board[current.row])-1 ||
			player == "O" && current.row == len(board)-1 {
			return true
		}
		neighbors := []point{
			{current.row, current.column - 1}, {current.row, current.column + 1},
			{current.row - 1, current.column - 1}, {current.row - 1, current.column},
			{current.row + 1, current.column}, {current.row + 1, current.column + 1},
		}
		for _, next := range neighbors {
			if next.row < 0 || next.row >= len(board) || next.column < 0 || next.column >= len(board[next.row]) ||
				board[next.row][next.column] != player || seen[next] {
				continue
			}
			seen[next] = true
			queue = append(queue, next)
		}
	}
	return false
}
