package sublist

// Relation type is defined in relations.go file.

func Sublist(l1, l2 []int) Relation {
	if len(l1) == len(l2) {
		if contains(l1, l2) {
			return RelationEqual
		}
		return RelationUnequal
	}
	if len(l1) < len(l2) {
		if contains(l2, l1) {
			return RelationSublist
		}
		return RelationUnequal
	}
	if contains(l1, l2) {
		return RelationSuperlist
	}
	return RelationUnequal
}

func contains(list, sub []int) bool {
	if len(sub) == 0 {
		return true
	}
	if len(sub) > len(list) {
		return false
	}
	for start := 0; start <= len(list)-len(sub); start++ {
		match := true
		for i := range sub {
			if list[start+i] != sub[i] {
				match = false
				break
			}
		}
		if match {
			return true
		}
	}
	return false
}
