package isbnverifier

func IsValidISBN(isbn string) bool {
	var normalized []byte
	for i := 0; i < len(isbn); i++ {
		if isbn[i] != '-' {
			normalized = append(normalized, isbn[i])
		}
	}
	if len(normalized) != 10 {
		return false
	}
	sum := 0
	for i := 0; i < 9; i++ {
		if normalized[i] < '0' || normalized[i] > '9' {
			return false
		}
		sum += int(normalized[i]-'0') * (10 - i)
	}
	check := 0
	if normalized[9] == 'X' {
		check = 10
	} else if normalized[9] >= '0' && normalized[9] <= '9' {
		check = int(normalized[9] - '0')
	} else {
		return false
	}
	return (sum+check)%11 == 0
}
