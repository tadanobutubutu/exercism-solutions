package house

import "strings"

var subjects = []string{
	"the house",
	"the malt",
	"the rat",
	"the cat",
	"the dog",
	"the cow with the crumpled horn",
	"the maiden all forlorn",
	"the man all tattered and torn",
	"the priest all shaven and shorn",
	"the rooster",
	"the farmer sowing his corn",
	"the horse and the hound and the horn",
}

var clauses = []string{
	"",
	"lay in the house that Jack built",
	"ate the malt",
	"killed the rat",
	"worried the cat",
	"tossed the dog",
	"milked the cow with the crumpled horn",
	"kissed the maiden all forlorn",
	"married the man all tattered and torn",
	"woke the priest all shaven and shorn",
	"kept the rooster that crowed in the morn",
	"belonged to the farmer sowing his corn",
}

func Verse(v int) string {
	if v < 1 || v > len(subjects) {
		return ""
	}
	lines := []string{"This is " + subjects[v-1]}
	if v == 10 {
		lines[0] += " that crowed in the morn"
	}
	for i := v - 1; i >= 1; i-- {
		lines = append(lines, "that "+clauses[i])
	}
	if v == 1 {
		lines[0] += " that Jack built"
	}
	return strings.Join(lines, "\n") + "."
}

func Song() string {
	verses := make([]string, len(subjects))
	for i := range verses {
		verses[i] = Verse(i + 1)
	}
	return strings.Join(verses, "\n\n")
}
