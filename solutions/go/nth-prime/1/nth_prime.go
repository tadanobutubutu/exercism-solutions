package nthprime

import "errors"

// Nth returns the nth prime number. An error must be returned if the nth prime number can't be calculated ('n' is equal or less than zero)
func Nth(n int) (int, error) {
	if n < 1 {
		return 0, errors.New("n must be positive")
	}

	primes := make([]int, 0, n)
	for candidate := 2; len(primes) < n; candidate++ {
		prime := true
		for _, divisor := range primes {
			if divisor > candidate/divisor {
				break
			}
			if candidate%divisor == 0 {
				prime = false
				break
			}
		}
		if prime {
			primes = append(primes, candidate)
		}
	}
	return primes[n-1], nil
}
