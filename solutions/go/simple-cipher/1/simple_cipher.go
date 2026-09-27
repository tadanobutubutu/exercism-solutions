package cipher

import (
	"strings"
)

// Define the shift and vigenere types here.
// Both types should satisfy the Cipher interface.
type shift struct {
	distance int
}

type vigenere struct {
	key string
}

func NewCaesar() Cipher {
	return NewShift(3)
}

func NewShift(distance int) Cipher {
	if distance == 0 || distance < -25 || distance > 25 {
		return nil
	}
	return shift{distance: distance}
}

func (c shift) Encode(input string) string {
	return transform(input, func(index int) int { return index + c.distance })
}

func (c shift) Decode(input string) string {
	return transform(input, func(index int) int { return index - c.distance })
}

func NewVigenere(key string) Cipher {
	if key == "" {
		return nil
	}
	allA := true
	for i := 0; i < len(key); i++ {
		if key[i] < 'a' || key[i] > 'z' {
			return nil
		}
		if key[i] != 'a' {
			allA = false
		}
	}
	if allA {
		return nil
	}
	return vigenere{key: key}
}

func (v vigenere) Encode(input string) string {
	position := 0
	return transform(input, func(index int) int {
		shift := int(v.key[position%len(v.key)] - 'a')
		position++
		return index + shift
	})
}

func (v vigenere) Decode(input string) string {
	position := 0
	return transform(input, func(index int) int {
		shift := int(v.key[position%len(v.key)] - 'a')
		position++
		return index - shift
	})
}

func transform(input string, shiftBy func(int) int) string {
	var output strings.Builder
	for _, letter := range input {
		var index int
		switch {
		case letter >= 'a' && letter <= 'z':
			index = int(letter - 'a')
		case letter >= 'A' && letter <= 'Z':
			index = int(letter - 'A')
		default:
			continue
		}
		index = ((shiftBy(index) % 26) + 26) % 26
		output.WriteByte(byte('a' + index))
	}
	return output.String()
}
