package sieve

func Sieve(limit int) []int {
	if limit < 2 {
		return nil
	}
	composite := make([]bool, limit+1)
	for prime := 2; prime <= limit/prime; prime++ {
		if !composite[prime] {
			for multiple := prime * prime; multiple <= limit; multiple += prime {
				composite[multiple] = true
			}
		}
	}
	primes := make([]int, 0)
	for number := 2; number <= limit; number++ {
		if !composite[number] {
			primes = append(primes, number)
		}
	}
	return primes
}
