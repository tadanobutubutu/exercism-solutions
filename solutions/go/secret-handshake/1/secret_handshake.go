package secrethandshake

func Handshake(code uint) []string {
	actions := []string{"wink", "double blink", "close your eyes", "jump"}
	result := make([]string, 0, len(actions))
	for bit, action := range actions {
		if code&(1<<bit) != 0 {
			result = append(result, action)
		}
	}
	if code&16 != 0 {
		for left, right := 0, len(result)-1; left < right; left, right = left+1, right-1 {
			result[left], result[right] = result[right], result[left]
		}
	}
	return result
}
