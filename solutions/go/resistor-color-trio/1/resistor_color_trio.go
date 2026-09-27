package resistorcolortrio

import "fmt"

var colorValue = map[string]int64{
	"black": 0, "brown": 1, "red": 2, "orange": 3, "yellow": 4,
	"green": 5, "blue": 6, "violet": 7, "grey": 8, "white": 9,
}

func Label(colors []string) string {
	if len(colors) < 3 {
		return "0 ohms"
	}
	value := colorValue[colors[0]]*10 + colorValue[colors[1]]
	for i := int64(0); i < colorValue[colors[2]]; i++ {
		value *= 10
	}
	unit := "ohms"
	for _, largerUnit := range []string{"kiloohms", "megaohms", "gigaohms"} {
		if value < 1000 || value%1000 != 0 {
			break
		}
		value /= 1000
		unit = largerUnit
	}
	return fmt.Sprintf("%d %s", value, unit)
}
