package piecingittogether

import (
	"errors"
	"math"
)

type PuzzleDetails struct {
	Pieces      int
	Border      int
	Inside      int
	Rows        int
	Columns     int
	AspectRatio float64
	Format      string
}

type dimensions struct{ rows, columns int }

func JigsawData(details PuzzleDetails) (PuzzleDetails, error) {
	if details.Pieces < 0 || details.Border < 0 || details.Inside < 0 || details.Rows < 0 || details.Columns < 0 ||
		math.IsNaN(details.AspectRatio) || math.IsInf(details.AspectRatio, 0) || details.AspectRatio < 0 {
		return PuzzleDetails{}, errors.New("Contradictory data")
	}
	switch details.Format {
	case "", "portrait", "square", "landscape":
	default:
		return PuzzleDetails{}, errors.New("Contradictory data")
	}

	candidates := candidateDimensions(details)
	valid := make([]dimensions, 0, len(candidates))
	for _, candidate := range candidates {
		if matches(details, candidate) {
			valid = append(valid, candidate)
		}
	}
	if len(valid) == 1 {
		return complete(valid[0]), nil
	}
	if len(valid) == 0 && (len(candidates) > 0 || enoughToContradict(details)) {
		return PuzzleDetails{}, errors.New("Contradictory data")
	}
	return PuzzleDetails{}, errors.New("Insufficient data")
}

func candidateDimensions(details PuzzleDetails) []dimensions {
	var candidates []dimensions
	if details.Rows > 0 && details.Columns > 0 {
		return []dimensions{{details.Rows, details.Columns}}
	}

	total := details.Pieces
	if total == 0 && details.Border > 0 && details.Inside > 0 {
		total = details.Border + details.Inside
	}
	if total > 0 {
		for rows := 1; rows <= total/rows; rows++ {
			if total%rows != 0 {
				continue
			}
			columns := total / rows
			candidates = append(candidates, dimensions{rows, columns}, dimensions{columns, rows})
		}
		return unique(candidates)
	}

	if details.Rows > 0 {
		rows := details.Rows
		if details.Columns > 0 {
			candidates = append(candidates, dimensions{rows, details.Columns})
		}
		if details.AspectRatio > 0 {
			candidates = append(candidates, dimensions{rows, int(math.Round(float64(rows) * details.AspectRatio))})
		}
		if details.Border > 0 {
			if rows == 1 {
				candidates = append(candidates, dimensions{rows, details.Border})
			} else {
				numerator := details.Border - 2*rows + 4
				if numerator > 0 && numerator%2 == 0 {
					candidates = append(candidates, dimensions{rows, numerator / 2})
				}
			}
		}
		if details.Inside > 0 && rows > 2 && details.Inside%(rows-2) == 0 {
			candidates = append(candidates, dimensions{rows, details.Inside/(rows-2) + 2})
		}
		if details.Format == "square" {
			candidates = append(candidates, dimensions{rows, rows})
		}
		return unique(candidates)
	}

	if details.Columns > 0 {
		columns := details.Columns
		if details.AspectRatio > 0 {
			candidates = append(candidates, dimensions{int(math.Round(float64(columns) / details.AspectRatio)), columns})
		}
		if details.Border > 0 {
			if columns == 1 {
				candidates = append(candidates, dimensions{details.Border, columns})
			} else {
				numerator := details.Border - 2*columns + 4
				if numerator > 0 && numerator%2 == 0 {
					candidates = append(candidates, dimensions{numerator / 2, columns})
				}
			}
		}
		if details.Inside > 0 && columns > 2 && details.Inside%(columns-2) == 0 {
			candidates = append(candidates, dimensions{details.Inside/(columns-2) + 2, columns})
		}
		if details.Format == "square" {
			candidates = append(candidates, dimensions{columns, columns})
		}
		return unique(candidates)
	}

	if details.Inside > 0 {
		for height := 1; height <= details.Inside/height; height++ {
			if details.Inside%height != 0 {
				continue
			}
			width := details.Inside / height
			candidates = append(candidates,
				dimensions{height + 2, width + 2},
				dimensions{width + 2, height + 2})
		}
	}
	if details.Border > 0 {
		if details.Border >= 3 {
			perimeterTwice := details.Border + 4
			if perimeterTwice%2 == 0 {
				sum := perimeterTwice / 2
				for rows := 2; rows <= sum-2; rows++ {
					columns := sum - rows
					candidates = append(candidates, dimensions{rows, columns})
				}
			}
		}
		candidates = append(candidates, dimensions{1, details.Border}, dimensions{details.Border, 1})
	}
	return unique(candidates)
}

func matches(given PuzzleDetails, d dimensions) bool {
	if d.rows < 1 || d.columns < 1 {
		return false
	}
	pieces := d.rows * d.columns
	inside := max(d.rows-2, 0) * max(d.columns-2, 0)
	border := pieces - inside
	ratio := float64(d.columns) / float64(d.rows)
	format := "square"
	if ratio < 1 {
		format = "portrait"
	} else if ratio > 1 {
		format = "landscape"
	}
	return (given.Pieces == 0 || given.Pieces == pieces) &&
		(given.Border == 0 || given.Border == border) &&
		(given.Inside == 0 || given.Inside == inside) &&
		(given.Rows == 0 || given.Rows == d.rows) &&
		(given.Columns == 0 || given.Columns == d.columns) &&
		(given.AspectRatio == 0 || math.Abs(given.AspectRatio-ratio) < 1e-9) &&
		(given.Format == "" || given.Format == format)
}

func complete(d dimensions) PuzzleDetails {
	pieces := d.rows * d.columns
	inside := max(d.rows-2, 0) * max(d.columns-2, 0)
	ratio := float64(d.columns) / float64(d.rows)
	format := "square"
	if ratio < 1 {
		format = "portrait"
	} else if ratio > 1 {
		format = "landscape"
	}
	return PuzzleDetails{
		Pieces: pieces, Border: pieces - inside, Inside: inside,
		Rows: d.rows, Columns: d.columns, AspectRatio: ratio, Format: format,
	}
}

func unique(input []dimensions) []dimensions {
	result := make([]dimensions, 0, len(input))
	seen := make(map[dimensions]bool, len(input))
	for _, candidate := range input {
		if candidate.rows > 0 && candidate.columns > 0 && !seen[candidate] {
			seen[candidate] = true
			result = append(result, candidate)
		}
	}
	return result
}

func enoughToContradict(details PuzzleDetails) bool {
	if details.Rows > 0 && (details.Columns > 0 || details.Pieces > 0 || details.Border > 0 || details.Inside > 0 || details.AspectRatio > 0 || details.Format == "square") {
		return true
	}
	if details.Columns > 0 && (details.Pieces > 0 || details.Border > 0 || details.Inside > 0 || details.AspectRatio > 0 || details.Format == "square") {
		return true
	}
	return details.Pieces > 0 || (details.Border > 0 && details.Inside > 0)
}
