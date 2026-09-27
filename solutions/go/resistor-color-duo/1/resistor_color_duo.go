package resistorcolorduo

var colorCodes = map[string]int{
	"black": 0, "brown": 1, "red": 2, "orange": 3, "yellow": 4,
	"green": 5, "blue": 6, "violet": 7, "grey": 8, "white": 9,
}

// Value returns the resistance value of a resistor from its first two bands.
func Value(colors []string) int {
	return colorCodes[colors[0]]*10 + colorCodes[colors[1]]
}
