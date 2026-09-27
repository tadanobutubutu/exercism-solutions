package twelvedays

import "strings"

var ordinals = []string{
	"first", "second", "third", "fourth", "fifth", "sixth",
	"seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth",
}

var gifts = []string{
	"a Partridge in a Pear Tree", "two Turtle Doves", "three French Hens",
	"four Calling Birds", "five Gold Rings", "six Geese-a-Laying",
	"seven Swans-a-Swimming", "eight Maids-a-Milking", "nine Ladies Dancing",
	"ten Lords-a-Leaping", "eleven Pipers Piping", "twelve Drummers Drumming",
}

func Verse(day int) string {
	if day < 1 || day > len(ordinals) {
		return ""
	}
	var verse strings.Builder
	verse.WriteString("On the ")
	verse.WriteString(ordinals[day-1])
	verse.WriteString(" day of Christmas my true love gave to me: ")
	for gift := day - 1; gift >= 0; gift-- {
		if gift == day-1 {
			// First gift in this verse.
		} else if gift == 0 {
			verse.WriteString(", and ")
		} else {
			verse.WriteString(", ")
		}
		verse.WriteString(gifts[gift])
	}
	verse.WriteByte('.')
	return verse.String()
}

func Song() string {
	verses := make([]string, len(ordinals))
	for day := range ordinals {
		verses[day] = Verse(day + 1)
	}
	return strings.Join(verses, "\n\n")
}
