package anagram

import (
	"sort"
	"strings"
)

func signature(word string) string {
	letters := []rune(strings.ToLower(word))
	sort.Slice(letters, func(i, j int) bool { return letters[i] < letters[j] })
	return string(letters)
}

func Detect(subject string, candidates []string) []string {
	target := signature(subject)
	normalizedSubject := strings.ToLower(subject)
	matches := make([]string, 0)
	for _, candidate := range candidates {
		normalizedCandidate := strings.ToLower(candidate)
		if normalizedCandidate == normalizedSubject || signature(candidate) != target {
			continue
		}
		matches = append(matches, candidate)
	}
	return matches
}
