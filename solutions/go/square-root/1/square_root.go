package squareroot

import "errors"

func SquareRoot(number int) (int, error) {
	if number <= 0 {
		return 0, errors.New("number must be positive")
	}
	low, high := 1, number
	for low <= high {
		middle := low + (high-low)/2
		quotient := number / middle
		switch {
		case middle == quotient && number%middle == 0:
			return middle, nil
		case middle > quotient:
			high = middle - 1
		default:
			low = middle + 1
		}
	}
	return 0, errors.New("number is not a perfect square")
}
