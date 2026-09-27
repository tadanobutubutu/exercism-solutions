package highscores

import "sort"

type HighScores struct {
	scores []int
}

// NewHighScores returns a new HighScores object.
func NewHighScores(scores []int) *HighScores {
	return &HighScores{scores: append([]int(nil), scores...)}
}

// Scores returns all the scores in submission order.
func (s *HighScores) Scores() []int {
	return append([]int(nil), s.scores...)
}

// Latest returns the latest score, or zero when there are no scores.
func (s *HighScores) Latest() int {
	if len(s.scores) == 0 {
		return 0
	}
	return s.scores[len(s.scores)-1]
}

// PersonalBest returns the highest score, or zero when there are no scores.
func (s *HighScores) PersonalBest() int {
	best := 0
	for index, score := range s.scores {
		if index == 0 || score > best {
			best = score
		}
	}
	return best
}

// TopThree returns up to three scores from highest to lowest.
func (s *HighScores) TopThree() []int {
	scores := append([]int(nil), s.scores...)
	sort.Sort(sort.Reverse(sort.IntSlice(scores)))
	if len(scores) > 3 {
		scores = scores[:3]
	}
	return scores
}
