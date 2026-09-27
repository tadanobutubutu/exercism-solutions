package saddlepoints

import (
	"fmt"
	"strconv"
	"strings"
)

type Matrix [][]int

func New(s string) (Matrix, error) {
	if strings.TrimSpace(s) == "" {
		return nil, fmt.Errorf("matrix must contain at least one row")
	}
	lines := strings.Split(s, "\n")
	matrix := make(Matrix, len(lines))
	width := -1
	for row, line := range lines {
		fields := strings.Fields(line)
		if len(fields) == 0 {
			return nil, fmt.Errorf("row %d is empty", row)
		}
		if width < 0 {
			width = len(fields)
		} else if len(fields) != width {
			return nil, fmt.Errorf("rows have different lengths")
		}
		matrix[row] = make([]int, len(fields))
		for col, field := range fields {
			value, err := strconv.Atoi(field)
			if err != nil {
				return nil, fmt.Errorf("invalid integer %q: %w", field, err)
			}
			matrix[row][col] = value
		}
	}
	return matrix, nil
}

func (m Matrix) Cols() [][]int {
	if len(m) == 0 {
		return nil
	}
	cols := make([][]int, len(m[0]))
	for col := range cols {
		cols[col] = make([]int, len(m))
		for row := range m {
			cols[col][row] = m[row][col]
		}
	}
	return cols
}

func (m Matrix) Rows() [][]int {
	rows := make([][]int, len(m))
	for i, row := range m {
		rows[i] = append([]int(nil), row...)
	}
	return rows
}

func (m Matrix) Set(row, col, val int) bool {
	if row < 0 || row >= len(m) || col < 0 || len(m) == 0 || col >= len(m[row]) {
		return false
	}
	m[row][col] = val
	return true
}
