package sumofmultiples

func SumMultiples(limit int, divisors ...int) int {
	multiples := make(map[int]struct{})
	for _, divisor := range divisors {
		if divisor <= 0 {
			continue
		}
		for multiple := divisor; multiple < limit; multiple += divisor {
			multiples[multiple] = struct{}{}
		}
	}
	total := 0
	for multiple := range multiples {
		total += multiple
	}
	return total
}
