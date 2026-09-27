package allyourbase

import "errors"

func ConvertToBase(inputBase int, inputDigits []int, outputBase int) ([]int, error) {
	if inputBase < 2 {
		return nil, errors.New("input base must be >= 2")
	}
	if outputBase < 2 {
		return nil, errors.New("output base must be >= 2")
	}
	for _, digit := range inputDigits {
		if digit < 0 || digit >= inputBase {
			return nil, errors.New("all digits must satisfy 0 <= d < input base")
		}
	}

	digits := append([]int(nil), inputDigits...)
	for len(digits) > 0 && digits[0] == 0 {
		digits = digits[1:]
	}
	if len(digits) == 0 {
		return []int{0}, nil
	}

	converted := make([]int, 0)
	for len(digits) > 0 {
		quotient := make([]int, 0, len(digits))
		remainder := 0
		for _, digit := range digits {
			value := remainder*inputBase + digit
			quotientDigit := value / outputBase
			remainder = value % outputBase
			if len(quotient) > 0 || quotientDigit != 0 {
				quotient = append(quotient, quotientDigit)
			}
		}
		converted = append(converted, remainder)
		digits = quotient
	}

	for left, right := 0, len(converted)-1; left < right; left, right = left+1, right-1 {
		converted[left], converted[right] = converted[right], converted[left]
	}
	return converted, nil
}
