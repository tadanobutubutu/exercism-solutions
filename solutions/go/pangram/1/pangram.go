package pangram

import "strings"

func IsPangram(input string) bool {
	var letters uint32
	for _, character := range strings.ToLower(input) {
		if character >= 'a' && character <= 'z' {
			letters |= 1 << uint(character-'a')
		}
	}
	return letters == (1<<26)-1
}
