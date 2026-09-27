package affinecipher

import (
	"fmt"
	"strings"
)

func Encode(text string, a, b int) (string, error) {
	if gcd(mod(a, 26), 26) != 1 {
		return "", fmt.Errorf("a and 26 must be coprime")
	}
	var encoded strings.Builder
	for _, r := range strings.ToLower(text) {
		switch {
		case r >= 'a' && r <= 'z':
			x := int(r - 'a')
			encoded.WriteByte(byte('a' + mod(a*x+b, 26)))
		case r >= '0' && r <= '9':
			encoded.WriteRune(r)
		}
	}
	return group(encoded.String()), nil
}

func Decode(text string, a, b int) (string, error) {
	a = mod(a, 26)
	if gcd(a, 26) != 1 {
		return "", fmt.Errorf("a and 26 must be coprime")
	}
	inverse := 0
	for i := 1; i < 26; i++ {
		if mod(a*i, 26) == 1 {
			inverse = i
			break
		}
	}
	var decoded strings.Builder
	for _, r := range strings.ToLower(text) {
		switch {
		case r >= 'a' && r <= 'z':
			y := int(r - 'a')
			decoded.WriteByte(byte('a' + mod(inverse*(y-b), 26)))
		case r >= '0' && r <= '9':
			decoded.WriteRune(r)
		}
	}
	return decoded.String(), nil
}

func mod(value, modulus int) int {
	return (value%modulus + modulus) % modulus
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func group(text string) string {
	if len(text) <= 5 {
		return text
	}
	var grouped strings.Builder
	for i, r := range text {
		if i > 0 && i%5 == 0 {
			grouped.WriteByte(' ')
		}
		grouped.WriteRune(r)
	}
	return grouped.String()
}
