package grep

import (
	"bufio"
	"os"
	"strconv"
	"strings"
)

func Search(pattern string, flags, files []string) []string {
	options := make(map[string]bool, len(flags))
	for _, flag := range flags {
		options[flag] = true
	}
	caseInsensitive := options["-i"]
	searchPattern := pattern
	if caseInsensitive {
		searchPattern = strings.ToLower(pattern)
	}
	withFilename := len(files) > 1
	results := make([]string, 0)

	for _, filename := range files {
		file, err := os.Open(filename)
		if err != nil {
			continue
		}
		scanner := bufio.NewScanner(file)
		lineNumber := 0
		fileMatches := false
		fileResults := make([]string, 0)
		for scanner.Scan() {
			lineNumber++
			line := scanner.Text()
			candidate := line
			if caseInsensitive {
				candidate = strings.ToLower(line)
			}
			matches := strings.Contains(candidate, searchPattern)
			if options["-x"] {
				matches = candidate == searchPattern
			}
			if options["-v"] {
				matches = !matches
			}
			if !matches {
				continue
			}
			fileMatches = true
			if options["-l"] {
				continue
			}
			var prefix strings.Builder
			if withFilename {
				prefix.WriteString(filename)
				prefix.WriteByte(':')
			}
			if options["-n"] {
				prefix.WriteString(strconv.Itoa(lineNumber))
				prefix.WriteByte(':')
			}
			fileResults = append(fileResults, prefix.String()+line)
		}
		file.Close()
		if options["-l"] && fileMatches {
			results = append(results, filename)
		} else if !options["-l"] {
			results = append(results, fileResults...)
		}
	}
	return results
}
