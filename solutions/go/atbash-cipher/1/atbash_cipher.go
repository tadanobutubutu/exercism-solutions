package atbashcipher

import "strings"

func Atbash(s string) string {
	var result strings.Builder
	count := 0
	for _, r := range strings.ToLower(s) {
		var encoded rune
		switch {
		case r >= 'a' && r <= 'z':
			encoded = 'z' - (r - 'a')
		case r >= '0' && r <= '9':
			encoded = r
		default:
			continue
		}
		if count > 0 && count%5 == 0 {
			result.WriteByte(' ')
		}
		result.WriteRune(encoded)
		count++
	}
	return result.String()
}
