package alphametics

import (
	"errors"
	"sort"
	"strings"
)

func Solve(puzzle string) (map[string]int, error) {
	sides := strings.Split(puzzle, "==")
	if len(sides) != 2 {
		return nil, errors.New("invalid puzzle")
	}
	addends := strings.Split(sides[0], "+")
	for i := range addends {
		addends[i] = strings.TrimSpace(strings.ToUpper(addends[i]))
	}
	result := strings.TrimSpace(strings.ToUpper(sides[1]))
	if result == "" {
		return nil, errors.New("invalid puzzle")
	}

	var assigned [256]int
	for i := range assigned {
		assigned[i] = -1
	}
	var leading [256]bool
	letters := make(map[byte]bool)
	maxLength := len(result)
	for _, word := range append(append([]string(nil), addends...), result) {
		if word == "" {
			return nil, errors.New("invalid puzzle")
		}
		if len(word) > maxLength {
			maxLength = len(word)
		}
		for i := range word {
			letter := word[i]
			if letter < 'A' || letter > 'Z' {
				return nil, errors.New("invalid puzzle")
			}
			letters[letter] = true
		}
		if len(word) > 1 {
			leading[word[0]] = true
		}
	}
	if len(letters) > 10 {
		return nil, errors.New("no solution")
	}
	var used [10]bool
	var solveColumn func(int, int) bool
	solveColumn = func(column, carry int) bool {
		if column == maxLength {
			return carry == 0
		}
		coefficients := make(map[byte]int)
		for _, word := range addends {
			index := len(word) - 1 - column
			if index >= 0 {
				coefficients[word[index]]++
			}
		}
		variables := make([]byte, 0, len(coefficients))
		for letter := range coefficients {
			if assigned[letter] < 0 {
				variables = append(variables, letter)
			}
		}
		output := byte(0)
		if column < len(result) {
			output = result[len(result)-1-column]
		}
		sort.Slice(variables, func(i, j int) bool {
			iIsOutput, jIsOutput := variables[i] == output, variables[j] == output
			if iIsOutput != jIsOutput {
				return iIsOutput
			}
			if coefficients[variables[i]] != coefficients[variables[j]] {
				return coefficients[variables[i]] > coefficients[variables[j]]
			}
			return variables[i] < variables[j]
		})

		var assignColumn func(int, int) bool
		assignColumn = func(index, sum int) bool {
			if index < len(variables) {
				letter := variables[index]
				for digit := 0; digit <= 9; digit++ {
					if used[digit] || digit == 0 && leading[letter] {
						continue
					}
					assigned[letter], used[digit] = digit, true
					if assignColumn(index+1, sum+coefficients[letter]*digit) {
						return true
					}
					assigned[letter], used[digit] = -1, false
				}
				return false
			}

			total := sum + carry
			digit := total % 10
			newOutput := false
			if output == 0 {
				if digit != 0 {
					return false
				}
			} else if assigned[output] >= 0 {
				if assigned[output] != digit {
					return false
				}
			} else {
				if used[digit] || digit == 0 && leading[output] {
					return false
				}
				assigned[output], used[digit] = digit, true
				newOutput = true
			}

			if solveColumn(column+1, total/10) {
				return true
			}
			if newOutput {
				assigned[output], used[digit] = -1, false
			}
			return false
		}
		return assignColumn(0, 0)
	}

	if !solveColumn(0, 0) {
		return nil, errors.New("no solution")
	}
	solution := make(map[string]int, len(letters))
	for letter := range letters {
		solution[string(letter)] = assigned[letter]
	}
	return solution, nil
}
