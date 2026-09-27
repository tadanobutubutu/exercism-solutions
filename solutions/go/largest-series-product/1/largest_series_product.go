package largestseriesproduct

import "errors"

func LargestSeriesProduct(digits string, span int) (int64, error) {
	if span < 0 {
		return 0, errors.New("span must not be negative")
	}
	if span > len(digits) {
		return 0, errors.New("span must not exceed string length")
	}
	for i := 0; i < len(digits); i++ {
		if digits[i] < '0' || digits[i] > '9' {
			return 0, errors.New("digits input must only contain digits")
		}
	}
	if span == 0 {
		return 1, nil
	}
	var largest int64
	for start := 0; start+span <= len(digits); start++ {
		product := int64(1)
		for i := start; i < start+span; i++ {
			product *= int64(digits[i] - '0')
		}
		if product > largest {
			largest = product
		}
	}
	return largest, nil
}
