package pythagorean

import "sort"

type Triplet [3]int

// Range generates all Pythagorean triplets whose sides are in [min, max].
func Range(min, max int) []Triplet {
	triplets := make([]Triplet, 0)
	if max < 1 {
		return triplets
	}
	if min < 1 {
		min = 1
	}

	for m := 2; m <= max/m; m++ {
		mSquared := m * m
		for n := 1; n < m; n++ {
			nSquared := n * n
			if nSquared > max-mSquared {
				continue
			}
			if (m-n)%2 == 0 || gcd(m, n) != 1 {
				continue
			}

			a, b, c := mSquared-nSquared, 2*m*n, mSquared+nSquared
			if a > b {
				a, b = b, a
			}
			firstScale := min / a
			if min%a != 0 {
				firstScale++
			}
			for scale := firstScale; scale <= max/c; scale++ {
				triplets = append(triplets, Triplet{scale * a, scale * b, scale * c})
			}
		}
	}
	sortTriplets(triplets)
	return triplets
}

// Sum returns all Pythagorean triplets with the requested perimeter.
func Sum(perimeter int) []Triplet {
	triplets := make([]Triplet, 0)
	if perimeter <= 0 {
		return triplets
	}

	for m := 2; m <= perimeter/(2*m); m++ {
		for n := 1; n < m; n++ {
			if (m-n)%2 == 0 || gcd(m, n) != 1 {
				continue
			}
			factor := 2 * (m + n)
			if m > perimeter/factor {
				continue
			}
			primitivePerimeter := factor * m
			if perimeter%primitivePerimeter != 0 {
				continue
			}

			a, b := m*m-n*n, 2*m*n
			if a > b {
				a, b = b, a
			}
			c := m*m + n*n
			scale := perimeter / primitivePerimeter
			triplets = append(triplets, Triplet{scale * a, scale * b, scale * c})
		}
	}
	sortTriplets(triplets)
	return triplets
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func sortTriplets(triplets []Triplet) {
	sort.Slice(triplets, func(i, j int) bool {
		for side := range 3 {
			if triplets[i][side] != triplets[j][side] {
				return triplets[i][side] < triplets[j][side]
			}
		}
		return false
	})
}
