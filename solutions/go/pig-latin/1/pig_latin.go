package piglatin

import "strings"

// Sentence translates each word of a sentence into Pig Latin.
func Sentence(sentence string) string {
	words := strings.Fields(sentence)
	for i, word := range words {
		words[i] = translateWord(word)
	}
	return strings.Join(words, " ")
}

func translateWord(word string) string {
	if word == "" {
		return word
	}
	if strings.HasPrefix(word, "xr") || strings.HasPrefix(word, "yt") || isVowel(word[0]) {
		return word + "ay"
	}
	if strings.HasPrefix(word, "qu") {
		return word[2:] + "quay"
	}

	cut := len(word)
	for i := 0; i < len(word); i++ {
		if i+1 < len(word) && word[i:i+2] == "qu" {
			cut = i + 2
			break
		}
		if word[i] == 'y' && i > 0 {
			cut = i
			break
		}
		if isVowel(word[i]) {
			cut = i
			break
		}
	}
	return word[cut:] + word[:cut] + "ay"
}

func isVowel(letter byte) bool {
	return strings.ContainsRune("aeiou", rune(letter))
}
