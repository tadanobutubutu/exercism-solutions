package flattenarray

func Flatten(nested any) []any {
	flattened := make([]any, 0)
	var appendValues func(any)
	appendValues = func(value any) {
		switch item := value.(type) {
		case nil:
			return
		case []any:
			for _, nestedItem := range item {
				appendValues(nestedItem)
			}
		default:
			flattened = append(flattened, item)
		}
	}
	appendValues(nested)
	return flattened
}
