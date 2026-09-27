package stateoftictactoe

import "errors"

type State string

const (
	Win     State = "win"
	Ongoing State = "ongoing"
	Draw    State = "draw"
)

var errInvalidBoard = errors.New("invalid tic-tac-toe board")

var winningLines = [8][3][2]int{
	{{0, 0}, {0, 1}, {0, 2}},
	{{1, 0}, {1, 1}, {1, 2}},
	{{2, 0}, {2, 1}, {2, 2}},
	{{0, 0}, {1, 0}, {2, 0}},
	{{0, 1}, {1, 1}, {2, 1}},
	{{0, 2}, {1, 2}, {2, 2}},
	{{0, 0}, {1, 1}, {2, 2}},
	{{0, 2}, {1, 1}, {2, 0}},
}

func StateOfTicTacToe(board []string) (State, error) {
	if len(board) != 3 {
		return "", errInvalidBoard
	}

	xCount, oCount, filled := 0, 0, 0
	for row := range board {
		if len(board[row]) != 3 {
			return "", errInvalidBoard
		}
		for col := range board[row] {
			switch board[row][col] {
			case 'X':
				xCount++
				filled++
			case 'O':
				oCount++
				filled++
			case ' ':
			default:
				return "", errInvalidBoard
			}
		}
	}
	if xCount != oCount && xCount != oCount+1 {
		return "", errInvalidBoard
	}

	xWins := hasWinner(board, 'X')
	oWins := hasWinner(board, 'O')
	if xWins && oWins {
		return "", errInvalidBoard
	}
	if xWins {
		if xCount != oCount+1 || !couldWinOnLastMove(board, 'X') {
			return "", errInvalidBoard
		}
		return Win, nil
	}
	if oWins {
		if xCount != oCount || !couldWinOnLastMove(board, 'O') {
			return "", errInvalidBoard
		}
		return Win, nil
	}
	if filled == 9 {
		return Draw, nil
	}
	return Ongoing, nil
}

func hasWinner(board []string, mark byte) bool {
	for _, line := range winningLines {
		if board[line[0][0]][line[0][1]] == mark &&
			board[line[1][0]][line[1][1]] == mark &&
			board[line[2][0]][line[2][1]] == mark {
			return true
		}
	}
	return false
}

func couldWinOnLastMove(board []string, mark byte) bool {
	for row := range board {
		for col := range board[row] {
			if board[row][col] != mark {
				continue
			}
			previous := []string{board[0], board[1], board[2]}
			cells := []byte(previous[row])
			cells[col] = ' '
			previous[row] = string(cells)
			if !hasWinner(previous, 'X') && !hasWinner(previous, 'O') {
				return true
			}
		}
	}
	return false
}
