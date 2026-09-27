package series

func All(n int, s string) []string {
	if n <= 0 || n > len(s) || len(s) == 0 {
		return nil
	}
	series := make([]string, 0, len(s)-n+1)
	for start := 0; start+n <= len(s); start++ {
		series = append(series, s[start:start+n])
	}
	return series
}

func UnsafeFirst(n int, s string) string {
	if n <= 0 || n > len(s) {
		return ""
	}
	return s[:n]
}

func First(n int, s string) (first string, ok bool) {
	if n <= 0 || n > len(s) || len(s) == 0 {
		return "", false
	}
	return s[:n], true
}
