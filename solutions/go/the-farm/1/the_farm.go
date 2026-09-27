package thefarm

import (
	"errors"
	"fmt"
)

// InvalidCowsError describes an invalid cow count and why it is invalid.
type InvalidCowsError struct {
	Cows    int
	Message string
}

func (e *InvalidCowsError) Error() string {
	return fmt.Sprintf("%d cows are invalid: %s", e.Cows, e.Message)
}

func DivideFood(calculator FodderCalculator, cows int) (float64, error) {
	amount, err := calculator.FodderAmount(cows)
	if err != nil {
		return 0, err
	}
	factor, err := calculator.FatteningFactor()
	if err != nil {
		return 0, err
	}
	return amount * factor / float64(cows), nil
}

func ValidateInputAndDivideFood(calculator FodderCalculator, cows int) (float64, error) {
	if cows <= 0 {
		return 0, errors.New("invalid number of cows")
	}
	return DivideFood(calculator, cows)
}

func ValidateNumberOfCows(cows int) error {
	if cows < 0 {
		return &InvalidCowsError{Cows: cows, Message: "there are no negative cows"}
	}
	if cows == 0 {
		return &InvalidCowsError{Cows: cows, Message: "no cows don't need food"}
	}
	return nil
}
