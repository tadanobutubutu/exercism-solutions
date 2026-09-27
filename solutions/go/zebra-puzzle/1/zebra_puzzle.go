package zebra

const (
	red = iota
	green
	ivory
	yellow
	blue
)

const (
	englishman = iota
	spaniard
	ukrainian
	norwegian
	japanese
)

const (
	coffee = iota
	tea
	milk
	orangeJuice
	water
)

const (
	dog = iota
	snails
	fox
	horse
	zebra
)

const (
	dancing = iota
	painter
	reading
	football
	chess
)

type Solution struct {
	DrinksWater string
	OwnsZebra   string
}

func SolvePuzzle() Solution {
	var answer Solution
	permutations(func(colors [5]int) bool {
		if colors[green] != colors[ivory]+1 {
			return false
		}
		return permutations(func(nations [5]int) bool {
			if nations[norwegian] != 0 || nations[englishman] != colors[red] ||
				abs(nations[norwegian]-colors[blue]) != 1 {
				return false
			}
			return permutations(func(drinks [5]int) bool {
				if drinks[milk] != 2 || drinks[coffee] != colors[green] ||
					drinks[tea] != nations[ukrainian] {
					return false
				}
				return permutations(func(pets [5]int) bool {
					if pets[dog] != nations[spaniard] {
						return false
					}
					return permutations(func(hobbies [5]int) bool {
						if hobbies[snails] != hobbies[dancing] ||
							hobbies[painter] != colors[yellow] ||
							hobbies[football] != drinks[orangeJuice] ||
							hobbies[chess] != nations[japanese] ||
							abs(hobbies[reading]-pets[fox]) != 1 ||
							abs(hobbies[painter]-pets[horse]) != 1 {
							return false
						}
						for name, position := range nations {
							if position == drinks[water] {
								answer.DrinksWater = nationalityName(name)
							}
							if position == pets[zebra] {
								answer.OwnsZebra = nationalityName(name)
							}
						}
						return true
					})
				})
			})
		})
	})
	return answer
}

func permutations(found func([5]int) bool) bool {
	var positions [5]int
	var used [5]bool
	var assign func(int) bool
	assign = func(value int) bool {
		if value == len(positions) {
			return found(positions)
		}
		for position := range used {
			if used[position] {
				continue
			}
			positions[value] = position
			used[position] = true
			if assign(value + 1) {
				return true
			}
			used[position] = false
		}
		return false
	}
	return assign(0)
}

func abs(value int) int {
	if value < 0 {
		return -value
	}
	return value
}

func nationalityName(index int) string {
	return [...]string{"Englishman", "Spaniard", "Ukrainian", "Norwegian", "Japanese"}[index]
}
