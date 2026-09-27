package runlengthencoding

import (
	"strconv"
	"strings"
)

func RunLengthEncode(input string) string {
	runes := []rune(input)
	if len(runes) == 0 {
		return ""
	}
	var encoded strings.Builder
	for start := 0; start < len(runes); {
		end := start + 1
		for end < len(runes) && runes[end] == runes[start] {
			end++
		}
		if count := end - start; count > 1 {
			encoded.WriteString(strconv.Itoa(count))
		}
		encoded.WriteRune(runes[start])
		start = end
	}
	return encoded.String()
}

func RunLengthDecode(input string) string {
	var decoded strings.Builder
	count := 0
	hasCount := false
	for _, r := range input {
		if r >= '0' && r <= '9' {
			count = count*10 + int(r-'0')
			hasCount = true
			continue
		}
		repeats := 1
		if hasCount {
			repeats = count
		}
		for i := 0; i < repeats; i++ {
			decoded.WriteRune(r)
		}
		count = 0
		hasCount = false
	}
	return decoded.String()
}
