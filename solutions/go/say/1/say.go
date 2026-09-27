package say

import "strings"

func Say(n int64) (string, bool) {
	if n < 0 || n > 999_999_999_999 {
		return "", false
	}
	if n == 0 {
		return "zero", true
	}

	scales := []struct {
		value int64
		name  string
	}{
		{1_000_000_000, "billion"},
		{1_000_000, "million"},
		{1_000, "thousand"},
		{1, ""},
	}
	var parts []string
	for _, scale := range scales {
		group := n / scale.value
		if group == 0 {
			continue
		}
		part := underThousand(int(group))
		if scale.name != "" {
			part += " " + scale.name
		}
		parts = append(parts, part)
		n %= scale.value
	}
	return strings.Join(parts, " "), true
}

func underThousand(n int) string {
	ones := [...]string{"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"}
	tens := [...]string{"", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"}
	var parts []string
	if n >= 100 {
		parts = append(parts, ones[n/100]+" hundred")
		n %= 100
	}
	if n >= 20 {
		word := tens[n/10]
		if n%10 != 0 {
			word += "-" + ones[n%10]
		}
		parts = append(parts, word)
	} else if n > 0 {
		parts = append(parts, ones[n])
	}
	return strings.Join(parts, " ")
}
