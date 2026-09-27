package romannumerals

import "errors"

func ToRomanNumeral(input int) (string, error) {
	if input < 1 || input > 3999 {
		return "", errors.New("value outside Roman numeral range")
	}
	values := []int{1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1}
	symbols := []string{"M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"}
	result := make([]byte, 0, 15)
	for i, value := range values {
		for input >= value {
			result = append(result, symbols[i]...)
			input -= value
		}
	}
	return string(result), nil
}
