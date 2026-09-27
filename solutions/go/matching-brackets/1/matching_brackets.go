package matchingbrackets

func Bracket(input string) bool {
	stack := make([]rune, 0)
	for _, ch := range input {
		switch ch {
		case '(', '[', '{':
			stack = append(stack, ch)
		case ')', ']', '}':
			if len(stack) == 0 {
				return false
			}
			open := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			if (ch == ')' && open != '(') ||
				(ch == ']' && open != '[') ||
				(ch == '}' && open != '{') {
				return false
			}
		}
	}
	return len(stack) == 0
}
