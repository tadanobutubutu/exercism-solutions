package camicia

import "strings"

type Outcome struct {
	finishes bool
	cards    int
	tricks   int
}

// SimulateGame plays until one player wins all cards or a deck state repeats.
func SimulateGame(playerA, playerB []string) Outcome {
	decks := [2][]string{
		append([]string(nil), playerA...),
		append([]string(nil), playerB...),
	}
	seen := make(map[string]struct{})
	current := 0
	cardsPlayed, tricks := 0, 0

	for {
		state := deckState(decks[0], decks[1])
		if _, repeated := seen[state]; repeated {
			return Outcome{finishes: false, cards: cardsPlayed, tricks: tricks}
		}
		seen[state] = struct{}{}

		pile := make([]string, 0, len(decks[0])+len(decks[1]))
		penalty, lastPaymentPlayer := 0, current
		winner := -1
		for winner < 0 {
			if len(decks[current]) == 0 {
				winner = 1 - current
				break
			}

			card := decks[current][0]
			decks[current] = decks[current][1:]
			pile = append(pile, card)
			cardsPlayed++

			if amount := paymentAmount(card); amount > 0 {
				penalty = amount
				lastPaymentPlayer = current
				current = 1 - current
				continue
			}

			if penalty > 0 {
				penalty--
				if penalty == 0 {
					winner = lastPaymentPlayer
				}
				continue
			}
			current = 1 - current
		}

		decks[winner] = append(decks[winner], pile...)
		tricks++
		if len(decks[0]) == 0 || len(decks[1]) == 0 {
			return Outcome{finishes: true, cards: cardsPlayed, tricks: tricks}
		}
		current = winner
	}
}

func paymentAmount(card string) int {
	switch card {
	case "J":
		return 1
	case "Q":
		return 2
	case "K":
		return 3
	case "A":
		return 4
	default:
		return 0
	}
}

func deckState(a, b []string) string {
	var state strings.Builder
	for _, deck := range [2][]string{a, b} {
		for _, card := range deck {
			if paymentAmount(card) == 0 {
				state.WriteByte('N')
			} else {
				state.WriteString(card)
			}
		}
		state.WriteByte('|')
	}
	return state.String()
}
