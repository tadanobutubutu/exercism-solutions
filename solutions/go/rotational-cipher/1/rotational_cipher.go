package rotationalcipher

func RotationalCipher(plain string, shiftKey int) string {
	shiftKey %= 26
	runes := []rune(plain)
	for i, r := range runes {
		switch {
		case r >= 'a' && r <= 'z':
			runes[i] = 'a' + (r-'a'+rune(shiftKey)+26)%26
		case r >= 'A' && r <= 'Z':
			runes[i] = 'A' + (r-'A'+rune(shiftKey)+26)%26
		}
	}
	return string(runes)
}
