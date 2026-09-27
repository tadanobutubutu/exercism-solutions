package foodchain

import "strings"

var animals = []string{"fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"}

func Verse(v int) string {
	if v < 1 || v > len(animals) {
		return ""
	}
	if v == 8 {
		return "I know an old lady who swallowed a horse.\nShe's dead, of course!"
	}

	lines := []string{"I know an old lady who swallowed a " + animals[v-1] + "."}
	special := map[int]string{
		2: "It wriggled and jiggled and tickled inside her.",
		3: "How absurd to swallow a bird!",
		4: "Imagine that, to swallow a cat!",
		5: "What a hog, to swallow a dog!",
		6: "Just opened her throat and swallowed a goat!",
		7: "I don't know how she swallowed a cow!",
	}
	if line, ok := special[v]; ok {
		lines = append(lines, line)
	}
	for i := v - 1; i >= 1; i-- {
		line := "She swallowed the " + animals[i] + " to catch the " + animals[i-1]
		if i-1 == 1 {
			line += " that wriggled and jiggled and tickled inside her"
		}
		lines = append(lines, line+".")
	}
	lines = append(lines, "I don't know why she swallowed the fly. Perhaps she'll die.")
	return strings.Join(lines, "\n")
}

func Verses(start, end int) string {
	verses := make([]string, 0, end-start+1)
	for verse := start; verse <= end; verse++ {
		verses = append(verses, Verse(verse))
	}
	return strings.Join(verses, "\n\n")
}

func Song() string {
	return Verses(1, 8)
}
