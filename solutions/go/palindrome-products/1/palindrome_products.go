package palindromeproducts

import "errors"

type Product struct {
	Product        int
	Factorizations [][2]int
}

func Products(fmin, fmax int) (Product, Product, error) {
	if fmin > fmax {
		return Product{}, Product{}, errors.New("min must be <= max")
	}
	minimum := Product{Factorizations: [][2]int{}}
	maximum := Product{Factorizations: [][2]int{}}
	found := false
	for left := fmin; left <= fmax; left++ {
		for right := left; right <= fmax; right++ {
			product := left * right
			if !isPalindrome(product) {
				continue
			}
			factors := [2]int{left, right}
			if !found || product < minimum.Product {
				minimum = Product{Product: product, Factorizations: [][2]int{factors}}
			} else if product == minimum.Product {
				minimum.Factorizations = append(minimum.Factorizations, factors)
			}
			if !found || product > maximum.Product {
				maximum = Product{Product: product, Factorizations: [][2]int{factors}}
			} else if product == maximum.Product {
				maximum.Factorizations = append(maximum.Factorizations, factors)
			}
			found = true
		}
	}
	return minimum, maximum, nil
}

func isPalindrome(value int) bool {
	if value < 0 {
		value = -value
	}
	original := value
	reversed := 0
	for value > 0 {
		reversed = reversed*10 + value%10
		value /= 10
	}
	return original == reversed
}
