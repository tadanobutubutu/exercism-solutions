package armstrongnumbers

func IsNumber(n int) bool {
	if n < 0 {
		return false
	}
	digits := 1
	for value := n; value >= 10; value /= 10 {
		digits++
	}

	sum := 0
	for value := n; value > 0; value /= 10 {
		digit := value % 10
		power := 1
		for exponent := 0; exponent < digits; exponent++ {
			power *= digit
		}
		if power > n-sum {
			return false
		}
		sum += power
	}
	return sum == n
}
