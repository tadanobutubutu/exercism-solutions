package bottlesong

func Recite(startBottles, takeDown int) []string {
	if startBottles < 1 || startBottles > 10 || takeDown < 1 {
		return []string{}
	}
	names := []string{"no", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"}
	titles := []string{"No", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"}
	verses := make([]string, 0, takeDown*5)
	end := startBottles - takeDown + 1
	if end < 1 {
		end = 1
	}
	for count := startBottles; count >= end; count-- {
		if len(verses) > 0 {
			verses = append(verses, "")
		}
		noun := "bottles"
		if count == 1 {
			noun = "bottle"
		}
		verses = append(verses,
			titles[count]+" green "+noun+" hanging on the wall,",
			titles[count]+" green "+noun+" hanging on the wall,",
			"And if one green bottle should accidentally fall,",
			"There'll be "+names[count-1]+" green "+map[bool]string{true: "bottle", false: "bottles"}[count-1 == 1]+" hanging on the wall.",
		)
	}
	return verses
}
