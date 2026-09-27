package lasagnamaster

// PreparationTime estimates preparation time from the number of layers.
func PreparationTime(layers []string, averagePreparationTime int) int {
	if averagePreparationTime == 0 {
		averagePreparationTime = 2
	}
	return len(layers) * averagePreparationTime
}

// Quantities returns the required grams of noodles and liters of sauce.
func Quantities(layers []string) (int, float64) {
	noodles, sauce := 0, 0.0
	for _, layer := range layers {
		switch layer {
		case "noodles":
			noodles += 50
		case "sauce":
			sauce += 0.2
		}
	}
	return noodles, sauce
}

// AddSecretIngredient replaces the final placeholder with the friend's secret ingredient.
func AddSecretIngredient(friendsList, myList []string) {
	if len(friendsList) > 0 && len(myList) > 0 {
		myList[len(myList)-1] = friendsList[len(friendsList)-1]
	}
}

// ScaleRecipe returns ingredient quantities scaled from two portions.
func ScaleRecipe(quantities []float64, portions int) []float64 {
	scale := float64(portions) / 2
	scaled := make([]float64, len(quantities))
	for i, amount := range quantities {
		scaled[i] = amount * scale
	}
	return scaled
}

// Your first steps could be to read through the tasks, and create
// these functions with their correct parameter lists and return types.
// The function body only needs to contain `panic("")`.
//
// This will make the tests compile, but they will fail.
// You can then implement the function logic one by one and see
// an increasing number of tests passing as you implement more
// functionality.
