package raindrops

import (
	"strconv"
	"strings"
)

func Convert(number int) string {
	var sounds strings.Builder
	if number%3 == 0 {
		sounds.WriteString("Pling")
	}
	if number%5 == 0 {
		sounds.WriteString("Plang")
	}
	if number%7 == 0 {
		sounds.WriteString("Plong")
	}
	if sounds.Len() == 0 {
		return strconv.Itoa(number)
	}
	return sounds.String()
}
