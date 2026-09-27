package pascalstriangle

func Triangle(n int) [][]int {
	if n <= 0 {
		return [][]int{}
	}
	triangle := make([][]int, n)
	for row := 0; row < n; row++ {
		triangle[row] = make([]int, row+1)
		triangle[row][0], triangle[row][row] = 1, 1
		for col := 1; col < row; col++ {
			triangle[row][col] = triangle[row-1][col-1] + triangle[row-1][col]
		}
	}
	return triangle
}
