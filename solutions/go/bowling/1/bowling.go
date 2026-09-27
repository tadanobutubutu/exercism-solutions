package bowling

import "errors"

type Game struct {
	rolls []int
}

func NewGame() *Game {
	return &Game{}
}

func (g *Game) Roll(pins int) error {
	if pins < 0 {
		return errors.New("Negative roll is invalid")
	}
	limit, over := nextRollLimit(g.rolls)
	if over {
		return errors.New("Cannot roll after game is over")
	}
	if pins > limit {
		return errors.New("Pin count exceeds pins on the lane")
	}
	g.rolls = append(g.rolls, pins)
	return nil
}

func (g *Game) Score() (int, error) {
	if _, over := nextRollLimit(g.rolls); !over {
		return 0, errors.New("Score cannot be taken until the end of the game")
	}
	score := 0
	roll := 0
	for frame := 0; frame < 9; frame++ {
		if g.rolls[roll] == 10 {
			score += 10 + g.rolls[roll+1] + g.rolls[roll+2]
			roll++
			continue
		}
		frameScore := g.rolls[roll] + g.rolls[roll+1]
		if frameScore == 10 {
			score += frameScore + g.rolls[roll+2]
		} else {
			score += frameScore
		}
		roll += 2
	}
	for _, pins := range g.rolls[roll:] {
		score += pins
	}
	return score, nil
}

func nextRollLimit(rolls []int) (int, bool) {
	index := 0
	for frame := 0; frame < 9; frame++ {
		if index >= len(rolls) {
			return 10, false
		}
		if rolls[index] == 10 {
			index++
			continue
		}
		if index+1 >= len(rolls) {
			return 10 - rolls[index], false
		}
		index += 2
	}

	remaining := len(rolls) - index
	if remaining == 0 {
		return 10, false
	}
	first := rolls[index]
	if first < 10 {
		if remaining == 1 {
			return 10 - first, false
		}
		second := rolls[index+1]
		if first+second < 10 {
			return 0, true
		}
		if remaining == 2 {
			return 10, false
		}
		return 0, true
	}
	if remaining == 1 {
		return 10, false
	}
	if remaining == 2 {
		if rolls[index+1] < 10 {
			return 10 - rolls[index+1], false
		}
		return 10, false
	}
	return 0, true
}
