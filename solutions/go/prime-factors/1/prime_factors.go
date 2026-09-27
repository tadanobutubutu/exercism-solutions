package primefactors

func Factors(n int64) []int64 {
	factors := []int64{}
	for divisor := int64(2); divisor <= n/divisor; divisor++ {
		for n%divisor == 0 {
			factors = append(factors, divisor)
			n /= divisor
		}
	}
	if n > 1 {
		factors = append(factors, n)
	}
	return factors
}
