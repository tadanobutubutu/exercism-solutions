package luhn

func Valid(id string) bool {
	digits := make([]int, 0, len(id))
	for _, character := range id {
		if character == ' ' {
			continue
		}
		if character < '0' || character > '9' {
			return false
		}
		digits = append(digits, int(character-'0'))
	}
	if len(digits) < 2 {
		return false
	}

	sum := 0
	double := false
	for index := len(digits) - 1; index >= 0; index-- {
		digit := digits[index]
		if double {
			digit *= 2
			if digit > 9 {
				digit -= 9
			}
		}
		sum += digit
		double = !double
	}
	return sum%10 == 0
}
