package bafflingbirthdays

import (
	"math/rand"
	"time"
)

func SharedBirthday(dates []time.Time) bool {
	seen := make(map[[2]int]struct{}, len(dates))
	for _, date := range dates {
		birthday := [2]int{int(date.Month()), date.Day()}
		if _, exists := seen[birthday]; exists {
			return true
		}
		seen[birthday] = struct{}{}
	}
	return false
}

func RandomBirthdates(size int) []time.Time {
	birthdates := make([]time.Time, size)
	start := time.Date(2001, time.January, 1, 0, 0, 0, 0, time.UTC)
	for i := range birthdates {
		birthdates[i] = start.AddDate(0, 0, rand.Intn(365))
	}
	return birthdates
}

func EstimatedProbability(size int) float64 {
	if size <= 1 {
		return 0
	}
	if size > 365 {
		return 100
	}
	probabilityNoSharedBirthday := 1.0
	for i := 0; i < size; i++ {
		probabilityNoSharedBirthday *= float64(365-i) / 365
	}
	return (1 - probabilityNoSharedBirthday) * 100
}
