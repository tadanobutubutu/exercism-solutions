package wordcount

import "strings"

type Frequency map[string]int

func WordCount(phrase string) Frequency {
	phrase = strings.ToLower(phrase)
	counts := make(Frequency)
	for i := 0; i < len(phrase); {
		if !isWordCharacter(phrase[i]) {
			i++
			continue
		}

		start := i
		for i < len(phrase) {
			if isWordCharacter(phrase[i]) {
				i++
				continue
			}
			if phrase[i] == '\'' && i+1 < len(phrase) && isWordCharacter(phrase[i+1]) {
				i++
				continue
			}
			break
		}
		counts[phrase[start:i]]++
	}
	return counts
}

func isWordCharacter(c byte) bool {
	return c >= 'a' && c <= 'z' || c >= '0' && c <= '9'
}
