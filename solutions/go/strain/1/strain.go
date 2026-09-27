package strain

// Implement the "Keep" and "Discard" function in this file.

// You will need typed parameters (aka "Generics") to solve this exercise.
// They are not part of the Exercism syllabus yet but you can learn about
// them here: https://go.dev/tour/generics/1

func Keep[T any](collection []T, predicate func(T) bool) []T {
	var kept []T
	for _, value := range collection {
		if predicate(value) {
			kept = append(kept, value)
		}
	}
	return kept
}

func Discard[T any](collection []T, predicate func(T) bool) []T {
	var discarded []T
	for _, value := range collection {
		if !predicate(value) {
			discarded = append(discarded, value)
		}
	}
	return discarded
}
