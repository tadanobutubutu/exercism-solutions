package blackjack

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
	values := map[string]int{
		"ace": 11, "two": 2, "three": 3, "four": 4, "five": 5,
		"six": 6, "seven": 7, "eight": 8, "nine": 9,
		"ten": 10, "jack": 10, "queen": 10, "king": 10,
	}
	return values[card]
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
	if card1 == "ace" && card2 == "ace" {
		return "P"
	}
	score := ParseCard(card1) + ParseCard(card2)
	if score == 21 {
		if ParseCard(dealerCard) == 10 || ParseCard(dealerCard) == 11 {
			return "S"
		}
		return "W"
	}
	if score >= 17 {
		return "S"
	}
	if score >= 12 && ParseCard(dealerCard) < 7 {
		return "S"
	}
	return "H"
}
