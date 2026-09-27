package listops

// IntList is an abstraction of a list of integers which we can define methods on
type IntList []int

func (s IntList) Foldl(fn func(int, int) int, initial int) int {
	acc := initial
	for _, value := range s {
		acc = fn(acc, value)
	}
	return acc
}

func (s IntList) Foldr(fn func(int, int) int, initial int) int {
	acc := initial
	for i := len(s) - 1; i >= 0; i-- {
		acc = fn(s[i], acc)
	}
	return acc
}

func (s IntList) Filter(fn func(int) bool) IntList {
	result := make(IntList, 0, len(s))
	for _, value := range s {
		if fn(value) {
			result = append(result, value)
		}
	}
	return result
}

func (s IntList) Length() int {
	return len(s)
}

func (s IntList) Map(fn func(int) int) IntList {
	result := make(IntList, len(s))
	for i, value := range s {
		result[i] = fn(value)
	}
	return result
}

func (s IntList) Reverse() IntList {
	result := make(IntList, len(s))
	for i, value := range s {
		result[len(s)-1-i] = value
	}
	return result
}

func (s IntList) Append(lst IntList) IntList {
	result := make(IntList, 0, len(s)+len(lst))
	result = append(result, s...)
	result = append(result, lst...)
	return result
}

func (s IntList) Concat(lists []IntList) IntList {
	total := 0
	for _, list := range lists {
		total += len(list)
	}
	result := make(IntList, 0, total)
	for _, list := range lists {
		result = append(result, list...)
	}
	return result
}
