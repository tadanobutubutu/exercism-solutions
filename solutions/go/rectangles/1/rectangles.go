package rectangles

func Count(diagram []string) int {
	if len(diagram) < 2 || len(diagram[0]) < 2 {
		return 0
	}
	height, width := len(diagram), len(diagram[0])
	count := 0
	for top := 0; top < height-1; top++ {
		for bottom := top + 1; bottom < height; bottom++ {
			for left := 0; left < width-1; left++ {
				if diagram[top][left] != '+' || diagram[bottom][left] != '+' ||
					!verticalSide(diagram, left, top, bottom) {
					continue
				}
				for right := left + 1; right < width; right++ {
					if diagram[top][right] != '+' || diagram[bottom][right] != '+' {
						continue
					}
					if horizontalSide(diagram[top], left, right) &&
						horizontalSide(diagram[bottom], left, right) &&
						verticalSide(diagram, right, top, bottom) {
						count++
					}
				}
			}
		}
	}
	return count
}

func horizontalSide(diagram string, left, right int) bool {
	for column := left + 1; column < right; column++ {
		if diagram[column] != '-' && diagram[column] != '+' {
			return false
		}
	}
	return true
}

func verticalSide(diagram []string, column, top, bottom int) bool {
	for row := top + 1; row < bottom; row++ {
		if diagram[row][column] != '|' && diagram[row][column] != '+' {
			return false
		}
	}
	return true
}
