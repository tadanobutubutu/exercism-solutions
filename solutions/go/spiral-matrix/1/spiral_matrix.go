package spiralmatrix

// SpiralMatrix creates a square matrix filled clockwise from the outside in.
func SpiralMatrix(size int) [][]int {
	if size <= 0 {
		return [][]int{}
	}

	matrix := make([][]int, size)
	for row := range matrix {
		matrix[row] = make([]int, size)
	}

	top, bottom, left, right := 0, size-1, 0, size-1
	value := 1
	for top <= bottom && left <= right {
		for col := left; col <= right; col++ {
			matrix[top][col] = value
			value++
		}
		top++

		for row := top; row <= bottom; row++ {
			matrix[row][right] = value
			value++
		}
		right--

		if top <= bottom {
			for col := right; col >= left; col-- {
				matrix[bottom][col] = value
				value++
			}
			bottom--
		}
		if left <= right {
			for row := bottom; row >= top; row-- {
				matrix[row][left] = value
				value++
			}
			left++
		}
	}
	return matrix
}
