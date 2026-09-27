package saddlepoints

import (
	"fmt"
	"strconv"
	"strings"
)

type Matrix [][]int

type Pair struct {
	Row, Column int
}

func New(s string) (*Matrix, error) {
	if strings.TrimSpace(s) == "" {
		m := Matrix{}
		return &m, nil
	}
	lines := strings.Split(s, "\n")
	matrix := make(Matrix, len(lines))
	width := -1
	for row, line := range lines {
		fields := strings.Fields(line)
		if len(fields) == 0 {
			return nil, fmt.Errorf("row %d is empty", row+1)
		}
		if width < 0 {
			width = len(fields)
		} else if width != len(fields) {
			return nil, fmt.Errorf("rows must have equal lengths")
		}
		matrix[row] = make([]int, len(fields))
		for col, field := range fields {
			value, err := strconv.Atoi(field)
			if err != nil {
				return nil, fmt.Errorf("invalid matrix value %q: %w", field, err)
			}
			matrix[row][col] = value
		}
	}
	return &matrix, nil
}

func (m *Matrix) Saddle() []Pair {
	if m == nil || len(*m) == 0 || len((*m)[0]) == 0 {
		return []Pair{}
	}
	rows := *m
	columnMin := make([]int, len(rows[0]))
	for col := range columnMin {
		columnMin[col] = rows[0][col]
		for row := 1; row < len(rows); row++ {
			if rows[row][col] < columnMin[col] {
				columnMin[col] = rows[row][col]
			}
		}
	}

	points := make([]Pair, 0)
	for row, values := range rows {
		max := values[0]
		for _, value := range values[1:] {
			if value > max {
				max = value
			}
		}
		for col, value := range values {
			if value == max && value == columnMin[col] {
				points = append(points, Pair{row + 1, col + 1})
			}
		}
	}
	return points
}
