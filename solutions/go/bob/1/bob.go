// Package bob models a teenager's terse responses.
package bob

import (
	"strings"
	"unicode"
)

// Hey returns Bob's response to remark.
func Hey(remark string) string {
	remark = strings.TrimSpace(remark)
	if remark == "" {
		return "Fine. Be that way!"
	}

	question := strings.HasSuffix(remark, "?")
	hasLetter := false
	shouting := true
	for _, character := range remark {
		if unicode.IsLetter(character) {
			hasLetter = true
			if !unicode.IsUpper(character) {
				shouting = false
			}
		}
	}
	shouting = shouting && hasLetter

	if question && shouting {
		return "Calm down, I know what I'm doing!"
	}
	if question {
		return "Sure."
	}
	if shouting {
		return "Whoa, chill out!"
	}
	return "Whatever."
}
