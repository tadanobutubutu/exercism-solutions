package forth

import (
	"errors"
	"strconv"
	"strings"
)

func Forth(input []string) ([]int, error) {
	tokens := strings.Fields(strings.Join(input, " "))
	definitions := make(map[string][]instruction)
	stack := []int{}
	for index := 0; index < len(tokens); index++ {
		word := strings.ToLower(tokens[index])
		if word != ":" {
			program, exists := definitions[word]
			if exists {
				if err := execute(program, &stack); err != nil {
					return nil, err
				}
			} else if value, err := strconv.Atoi(word); err == nil {
				stack = append(stack, value)
			} else if isBuiltin(word) {
				if err := execute([]instruction{{kind: "builtin", operation: word}}, &stack); err != nil {
					return nil, err
				}
			} else {
				return nil, errors.New("undefined operation")
			}
			continue
		}

		if index+1 >= len(tokens) {
			return nil, errors.New("illegal operation")
		}
		name := strings.ToLower(tokens[index+1])
		if _, err := strconv.Atoi(name); err == nil {
			return nil, errors.New("illegal operation")
		}
		end := index + 2
		for end < len(tokens) && tokens[end] != ";" {
			end++
		}
		if end == len(tokens) {
			return nil, errors.New("illegal operation")
		}
		program := make([]instruction, 0, end-index-2)
		for _, bodyWord := range tokens[index+2 : end] {
			program = append(program, compileWord(strings.ToLower(bodyWord), definitions)...)
		}
		definitions[name] = program
		index = end
	}
	return stack, nil
}

type instruction struct {
	kind      string
	operation string
	value     int
}

func compileWord(word string, definitions map[string][]instruction) []instruction {
	if value, err := strconv.Atoi(word); err == nil {
		return []instruction{{kind: "number", value: value}}
	}
	if program, exists := definitions[word]; exists {
		return append([]instruction(nil), program...)
	}
	if isBuiltin(word) {
		return []instruction{{kind: "builtin", operation: word}}
	}
	return []instruction{{kind: "word", operation: word}}
}

func isBuiltin(word string) bool {
	switch word {
	case "+", "-", "*", "/", "dup", "drop", "swap", "over":
		return true
	default:
		return false
	}
}

func execute(program []instruction, stack *[]int) error {
	for _, operation := range program {
		if operation.kind == "number" {
			*stack = append(*stack, operation.value)
			continue
		}
		if operation.kind == "word" {
			return errors.New("undefined operation")
		}
		values := *stack
		switch operation.operation {
		case "+", "-", "*", "/":
			if len(values) == 0 {
				return errors.New("empty stack")
			}
			if len(values) == 1 {
				return errors.New("only one value on the stack")
			}
			right := values[len(values)-1]
			left := values[len(values)-2]
			if operation.operation == "/" && right == 0 {
				return errors.New("divide by zero")
			}
			values = values[:len(values)-2]
			switch operation.operation {
			case "+":
				values = append(values, left+right)
			case "-":
				values = append(values, left-right)
			case "*":
				values = append(values, left*right)
			case "/":
				values = append(values, left/right)
			}
			*stack = values
		case "dup":
			if len(values) == 0 {
				return errors.New("empty stack")
			}
			*stack = append(values, values[len(values)-1])
		case "drop":
			if len(values) == 0 {
				return errors.New("empty stack")
			}
			*stack = values[:len(values)-1]
		case "swap":
			if len(values) == 0 {
				return errors.New("empty stack")
			}
			if len(values) == 1 {
				return errors.New("only one value on the stack")
			}
			values[len(values)-1], values[len(values)-2] = values[len(values)-2], values[len(values)-1]
		case "over":
			if len(values) == 0 {
				return errors.New("empty stack")
			}
			if len(values) == 1 {
				return errors.New("only one value on the stack")
			}
			*stack = append(values, values[len(values)-2])
		default:
			return errors.New("undefined operation")
		}
	}
	return nil
}
