package darts

func Score(x, y float64) int {
	distanceSquared := x*x + y*y
	switch {
	case distanceSquared <= 1:
		return 10
	case distanceSquared <= 25:
		return 5
	case distanceSquared <= 100:
		return 1
	default:
		return 0
	}
}
