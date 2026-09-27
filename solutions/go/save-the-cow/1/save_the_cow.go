package savethecow

import (
	"errors"
	"strings"
)

type Game struct {
	word     []rune
	guessed  map[rune]bool
	failures int
}

func NewGame(word string) *Game {
	return &Game{word: []rune(word), guessed: make(map[rune]bool)}
}

func (g *Game) Guess(r rune) error {
	switch g.State() {
	case "Lose":
		return errors.New("cannot guess after the game is lost")
	case "Win":
		return errors.New("cannot guess after the game is won")
	}
	if g.guessed[r] {
		g.failures++
		return nil
	}
	g.guessed[r] = true
	for _, letter := range g.word {
		if letter == r {
			return nil
		}
	}
	g.failures++
	return nil
}

func (g *Game) MaskedWord() string {
	var masked strings.Builder
	for _, letter := range g.word {
		if g.guessed[letter] {
			masked.WriteRune(letter)
		} else {
			masked.WriteRune('_')
		}
	}
	return masked.String()
}

func (g *Game) RemainingGuesses() int {
	remaining := 9 - g.failures
	if remaining < 0 {
		return 0
	}
	return remaining
}

func (g *Game) State() string {
	if g.failures >= 10 {
		return "Lose"
	}
	for _, letter := range g.word {
		if !g.guessed[letter] {
			return "Ongoing"
		}
	}
	return "Win"
}
