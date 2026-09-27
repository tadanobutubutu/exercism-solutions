package resistorcolor

var colorList = []string{
	"black", "brown", "red", "orange", "yellow",
	"green", "blue", "violet", "grey", "white",
}

// Colors returns the list of all colors.
func Colors() []string {
	return append([]string(nil), colorList...)
}

// ColorCode returns the resistance value of the given color.
func ColorCode(color string) int {
	for code, name := range colorList {
		if name == color {
			return code
		}
	}
	return -1
}
