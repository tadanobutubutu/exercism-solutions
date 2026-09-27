package rationalnumbers

import "math"

type Rational struct {
	numerator, denominator int
}

func (r Rational) Reduce() Rational {
	if r.denominator < 0 {
		r.numerator = -r.numerator
		r.denominator = -r.denominator
	}
	if r.numerator == 0 {
		return Rational{0, 1}
	}
	g := gcd(abs(r.numerator), r.denominator)
	return Rational{r.numerator / g, r.denominator / g}
}

func (r Rational) Add(s Rational) Rational {
	return Rational{r.numerator*s.denominator + s.numerator*r.denominator, r.denominator * s.denominator}.Reduce()
}

func (r Rational) Sub(s Rational) Rational {
	return Rational{r.numerator*s.denominator - s.numerator*r.denominator, r.denominator * s.denominator}.Reduce()
}

func (r Rational) Mul(s Rational) Rational {
	return Rational{r.numerator * s.numerator, r.denominator * s.denominator}.Reduce()
}

func (r Rational) Div(s Rational) Rational {
	return Rational{r.numerator * s.denominator, r.denominator * s.numerator}.Reduce()
}

func (r Rational) Abs() Rational {
	r = r.Reduce()
	return Rational{abs(r.numerator), r.denominator}
}

// Compute r ^ power, a rational raised to an int exponent.
func (r Rational) Exprational(power int) Rational {
	r = r.Reduce()
	if power == 0 {
		return Rational{1, 1}
	}
	if power < 0 {
		r.numerator, r.denominator = r.denominator, r.numerator
		power = -power
	}
	result := Rational{1, 1}
	base := r
	for power > 0 {
		if power&1 == 1 {
			result = result.Mul(base)
		}
		power >>= 1
		if power > 0 {
			base = base.Mul(base)
		}
	}
	return result.Reduce()
}

// Compute base ^ r, an int raised to a rational.
func (r Rational) Expreal(base int) float64 {
	r = r.Reduce()
	return math.Pow(float64(base), float64(r.numerator)/float64(r.denominator))
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func abs(n int) int {
	if n < 0 {
		return -n
	}
	return n
}
