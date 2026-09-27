package parallelletterfrequency

import (
	"runtime"
	"sync"
	"unicode"
)

// FreqMap records the frequency of each rune in a given text.
type FreqMap map[rune]int

// Frequency counts Unicode letters in a text without regard to case.
func Frequency(text string) FreqMap {
	counts := make(FreqMap)
	for _, r := range text {
		if unicode.IsLetter(r) {
			counts[unicode.ToLower(r)]++
		}
	}
	return counts
}

// ConcurrentFrequency counts letter frequencies by processing texts concurrently.
func ConcurrentFrequency(texts []string) FreqMap {
	total := make(FreqMap)
	if len(texts) == 0 {
		return total
	}

	workers := runtime.GOMAXPROCS(0)
	if workers > len(texts) {
		workers = len(texts)
	}
	jobs := make(chan string)
	results := make(chan FreqMap, len(texts))
	var wg sync.WaitGroup
	for i := 0; i < workers; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for text := range jobs {
				results <- Frequency(text)
			}
		}()
	}
	go func() {
		for _, text := range texts {
			jobs <- text
		}
		close(jobs)
		wg.Wait()
		close(results)
	}()
	for part := range results {
		for letter, count := range part {
			total[letter] += count
		}
	}
	return total
}
