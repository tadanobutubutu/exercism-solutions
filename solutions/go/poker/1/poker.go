package poker

import (
	"errors"
	"sort"
	"strconv"
	"strings"
)

func BestHand(hands []string) ([]string, error) {
	if len(hands) == 0 {
		return []string{}, nil
	}
	scores := make([]handScore, len(hands))
	best := 0
	for i, hand := range hands {
		score, err := scoreHand(hand)
		if err != nil {
			return nil, err
		}
		scores[i] = score
		if i > 0 && compare(scores[i], scores[best]) > 0 {
			best = i
		}
	}
	winners := make([]string, 0, len(hands))
	for i, hand := range hands {
		if compare(scores[i], scores[best]) == 0 {
			winners = append(winners, hand)
		}
	}
	return winners, nil
}

type rankCount struct {
	rank  int
	count int
}

type handScore struct {
	category int
	tiebreak []int
}

func scoreHand(hand string) (handScore, error) {
	cards := strings.Fields(hand)
	if len(cards) != 5 {
		return handScore{}, errors.New("a hand must contain five cards")
	}
	ranks := make([]int, 0, 5)
	counts := make(map[int]int)
	suit := ""
	flush := true
	for index, card := range cards {
		runes := []rune(card)
		if len(runes) < 2 {
			return handScore{}, errors.New("invalid card")
		}
		currentSuit := string(runes[len(runes)-1])
		if currentSuit != "♤" && currentSuit != "♡" && currentSuit != "♢" && currentSuit != "♧" {
			return handScore{}, errors.New("invalid suit")
		}
		if index == 0 {
			suit = currentSuit
		} else if currentSuit != suit {
			flush = false
		}
		rankText := string(runes[:len(runes)-1])
		rank, err := parseRank(rankText)
		if err != nil {
			return handScore{}, err
		}
		ranks = append(ranks, rank)
		counts[rank]++
	}
	sort.Sort(sort.Reverse(sort.IntSlice(ranks)))

	straight := true
	for i := 1; i < len(ranks); i++ {
		if ranks[i-1] == ranks[i] || ranks[i-1]-1 != ranks[i] {
			straight = false
			break
		}
	}
	straightHigh := ranks[0]
	if !straight && ranks[0] == 14 && ranks[1] == 5 && ranks[2] == 4 && ranks[3] == 3 && ranks[4] == 2 {
		straight = true
		straightHigh = 5
	}

	groups := make([]rankCount, 0, len(counts))
	for rank, count := range counts {
		groups = append(groups, rankCount{rank: rank, count: count})
	}
	sort.Slice(groups, func(i, j int) bool {
		if groups[i].count != groups[j].count {
			return groups[i].count > groups[j].count
		}
		return groups[i].rank > groups[j].rank
	})

	switch {
	case straight && flush:
		return handScore{category: 8, tiebreak: []int{straightHigh}}, nil
	case groups[0].count == 4:
		return handScore{category: 7, tiebreak: []int{groups[0].rank, groups[1].rank}}, nil
	case groups[0].count == 3 && groups[1].count == 2:
		return handScore{category: 6, tiebreak: []int{groups[0].rank, groups[1].rank}}, nil
	case flush:
		return handScore{category: 5, tiebreak: ranks}, nil
	case straight:
		return handScore{category: 4, tiebreak: []int{straightHigh}}, nil
	case groups[0].count == 3:
		return handScore{category: 3, tiebreak: []int{groups[0].rank, groups[1].rank, groups[2].rank}}, nil
	case groups[0].count == 2 && groups[1].count == 2:
		return handScore{category: 2, tiebreak: []int{groups[0].rank, groups[1].rank, groups[2].rank}}, nil
	case groups[0].count == 2:
		return handScore{category: 1, tiebreak: []int{groups[0].rank, groups[1].rank, groups[2].rank, groups[3].rank}}, nil
	default:
		return handScore{category: 0, tiebreak: ranks}, nil
	}
}

func parseRank(rank string) (int, error) {
	switch rank {
	case "J":
		return 11, nil
	case "Q":
		return 12, nil
	case "K":
		return 13, nil
	case "A":
		return 14, nil
	}
	value, err := strconv.Atoi(rank)
	if err != nil || value < 2 || value > 10 {
		return 0, errors.New("invalid card rank")
	}
	return value, nil
}

func compare(left, right handScore) int {
	if left.category != right.category {
		if left.category > right.category {
			return 1
		}
		return -1
	}
	for i := 0; i < len(left.tiebreak) && i < len(right.tiebreak); i++ {
		if left.tiebreak[i] > right.tiebreak[i] {
			return 1
		}
		if left.tiebreak[i] < right.tiebreak[i] {
			return -1
		}
	}
	return 0
}
