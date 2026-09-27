package phonenumber

import "errors"

func Number(phoneNumber string) (string, error) {
	digits, err := clean(phoneNumber)
	if err != nil {
		return "", err
	}
	return digits, nil
}

func AreaCode(phoneNumber string) (string, error) {
	digits, err := clean(phoneNumber)
	if err != nil {
		return "", err
	}
	return digits[:3], nil
}

func Format(phoneNumber string) (string, error) {
	digits, err := clean(phoneNumber)
	if err != nil {
		return "", err
	}
	return "(" + digits[:3] + ") " + digits[3:6] + "-" + digits[6:], nil
}

func clean(phoneNumber string) (string, error) {
	digits := make([]byte, 0, 11)
	for i := 0; i < len(phoneNumber); i++ {
		ch := phoneNumber[i]
		if ch >= '0' && ch <= '9' {
			digits = append(digits, ch)
			continue
		}
		switch ch {
		case ' ', '\t', '\n', '-', '.', '(', ')', '+':
		default:
			return "", errors.New("phone number contains an invalid character")
		}
	}
	if len(digits) == 11 {
		if digits[0] != '1' {
			return "", errors.New("11-digit number must start with country code 1")
		}
		digits = digits[1:]
	}
	if len(digits) != 10 {
		return "", errors.New("phone number must contain 10 digits")
	}
	if digits[0] < '2' || digits[0] > '9' || digits[3] < '2' || digits[3] > '9' {
		return "", errors.New("area and exchange codes must begin with 2 through 9")
	}
	return string(digits), nil
}
