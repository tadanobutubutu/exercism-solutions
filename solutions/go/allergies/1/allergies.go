package allergies

var allergens = []struct {
	name  string
	score uint
}{
	{"eggs", 1},
	{"peanuts", 2},
	{"shellfish", 4},
	{"strawberries", 8},
	{"tomatoes", 16},
	{"chocolate", 32},
	{"pollen", 64},
	{"cats", 128},
}

func Allergies(allergies uint) []string {
	result := make([]string, 0, len(allergens))
	for _, allergen := range allergens {
		if allergies&allergen.score != 0 {
			result = append(result, allergen.name)
		}
	}
	return result
}

func AllergicTo(allergies uint, allergen string) bool {
	for _, item := range allergens {
		if item.name == allergen {
			return allergies&item.score != 0
		}
	}
	return false
}
