package perfectnumbers

import "errors"

// Classification describes a positive integer by its aliquot sum.
type Classification int

const (
	ClassificationDeficient Classification = iota
	ClassificationPerfect
	ClassificationAbundant
)

var ErrOnlyPositive = errors.New("only positive integers can be classified")

// Classify determines whether n is deficient, perfect, or abundant.
func Classify(n int64) (Classification, error) {
	if n <= 0 {
		return ClassificationDeficient, ErrOnlyPositive
	}

	var aliquotSum int64
	if n > 1 {
		aliquotSum = 1
	}
	for divisor := int64(2); divisor <= n/divisor; divisor++ {
		if n%divisor != 0 {
			continue
		}
		aliquotSum += divisor
		partner := n / divisor
		if partner != divisor {
			aliquotSum += partner
		}
	}

	switch {
	case aliquotSum < n:
		return ClassificationDeficient, nil
	case aliquotSum == n:
		return ClassificationPerfect, nil
	default:
		return ClassificationAbundant, nil
	}
}
