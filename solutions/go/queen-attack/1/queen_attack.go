package queenattack

import "fmt"

func parsePosition(position string) (int, int, error) {
	if len(position) != 2 || position[0] < 'a' || position[0] > 'h' || position[1] < '1' || position[1] > '8' {
		return 0, 0, fmt.Errorf("invalid chess position %q", position)
	}
	return int(position[0] - 'a'), int(position[1] - '1'), nil
}

func CanQueenAttack(whitePosition, blackPosition string) (bool, error) {
	whiteCol, whiteRow, err := parsePosition(whitePosition)
	if err != nil {
		return false, err
	}
	blackCol, blackRow, err := parsePosition(blackPosition)
	if err != nil {
		return false, err
	}
	if whiteCol == blackCol && whiteRow == blackRow {
		return false, fmt.Errorf("queens cannot occupy the same square")
	}
	colDiff := abs(whiteCol - blackCol)
	rowDiff := abs(whiteRow - blackRow)
	return whiteCol == blackCol || whiteRow == blackRow || colDiff == rowDiff, nil
}

func abs(n int) int {
	if n < 0 {
		return -n
	}
	return n
}
