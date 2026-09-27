package wordy

import (
	"strconv"
	"strings"
)

// Answer evaluates a supported math question from left to right.
func Answer(question string) (int, bool) {
	question = strings.TrimSpace(question)
	if !strings.HasPrefix(question, "What is ") || !strings.HasSuffix(question, "?") {
		return 0, false
	}
	parts := strings.Fields(strings.TrimSuffix(strings.TrimPrefix(question, "What is "), "?"))
	if len(parts) == 0 {
		return 0, false
	}

	answer, err := strconv.Atoi(parts[0])
	if err != nil {
		return 0, false
	}
	for i := 1; i < len(parts); {
		operation := parts[i]
		i++
		if operation == "multiplied" || operation == "divided" {
			if i >= len(parts) || parts[i] != "by" {
				return 0, false
			}
			i++
		}
		if i >= len(parts) {
			return 0, false
		}
		operand, parseErr := strconv.Atoi(parts[i])
		if parseErr != nil {
			return 0, false
		}
		i++

		switch operation {
		case "plus":
			answer += operand
		case "minus":
			answer -= operand
		case "multiplied":
			answer *= operand
		case "divided":
			if operand == 0 {
				return 0, false
			}
			answer /= operand
		default:
			return 0, false
		}
	}
	return answer, true
}
