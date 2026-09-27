package parsinglogfiles

import (
	"regexp"
	"strings"
)

var (
	logPrefixPattern = regexp.MustCompile(`^\[(TRC|DBG|INF|WRN|ERR|FTL)\]`)
	logSeparator     = regexp.MustCompile(`<[-~*=]*>`)
	quotedPassword   = regexp.MustCompile(`(?i)password`)
	endOfLineTag     = regexp.MustCompile(`end-of-line[0-9]+`)
)

func IsValidLine(text string) bool {
	return logPrefixPattern.MatchString(text)
}

func SplitLogLine(text string) []string {
	return logSeparator.Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
	count := 0
	for _, line := range lines {
		start := strings.IndexByte(line, '"')
		if start < 0 {
			continue
		}
		end := strings.IndexByte(line[start+1:], '"')
		if end < 0 {
			continue
		}
		if quotedPassword.MatchString(line[start+1 : start+1+end]) {
			count++
		}
	}
	return count
}

func RemoveEndOfLineText(text string) string {
	return endOfLineTag.ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
	tagged := make([]string, len(lines))
	for i, line := range lines {
		tagged[i] = line
		marker := strings.Index(line, "User ")
		if marker < 0 {
			continue
		}
		fields := strings.Fields(line[marker+len("User "):])
		if len(fields) > 0 {
			tagged[i] = "[USR] " + fields[0] + " " + line
		}
	}
	return tagged
}
