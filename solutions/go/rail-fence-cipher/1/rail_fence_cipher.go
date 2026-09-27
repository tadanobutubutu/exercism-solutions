package railfencecipher

import "strings"

func Encode(message string, rails int) string {
	characters := []rune(message)
	if rails <= 1 || rails >= len(characters) {
		return message
	}
	rows := make([]strings.Builder, rails)
	for index, character := range characters {
		rows[railAt(index, rails)].WriteRune(character)
	}
	var encoded strings.Builder
	for i := range rows {
		encoded.WriteString(rows[i].String())
	}
	return encoded.String()
}

func Decode(message string, rails int) string {
	characters := []rune(message)
	if rails <= 1 || rails >= len(characters) {
		return message
	}
	counts := make([]int, rails)
	for index := range characters {
		counts[railAt(index, rails)]++
	}
	rows := make([][]rune, rails)
	position := 0
	for rail, count := range counts {
		rows[rail] = characters[position : position+count]
		position += count
	}
	used := make([]int, rails)
	decoded := make([]rune, len(characters))
	for index := range decoded {
		rail := railAt(index, rails)
		decoded[index] = rows[rail][used[rail]]
		used[rail]++
	}
	return string(decoded)
}

func railAt(index, rails int) int {
	period := 2 * (rails - 1)
	position := index % period
	if position < rails {
		return position
	}
	return period - position
}
