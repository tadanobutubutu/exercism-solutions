package kindergartengarden

import (
	"errors"
	"sort"
	"strings"
)

var defaultChildren = []string{
	"Alice", "Bob", "Charlie", "David", "Eve", "Fred",
	"Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry",
}

var plantNames = map[byte]string{
	'G': "grass",
	'C': "clover",
	'R': "radishes",
	'V': "violets",
}

type Garden struct {
	plants map[string][]string
}

func NewGarden(diagram string, children []string) (*Garden, error) {
	if !strings.HasPrefix(diagram, "\n") {
		return nil, errors.New("diagram must start with a newline")
	}
	rows := strings.Split(strings.TrimPrefix(diagram, "\n"), "\n")
	if len(rows) != 2 || len(rows[0]) != len(rows[1]) {
		return nil, errors.New("diagram must contain two rows of equal length")
	}
	if len(rows[0])%2 != 0 {
		return nil, errors.New("each row must contain an even number of cups")
	}
	if len(children) == 0 {
		children = defaultChildren
	} else {
		children = append([]string(nil), children...)
		sort.Strings(children)
	}
	if len(rows[0]) != 2*len(children) {
		return nil, errors.New("cup count does not match the number of children")
	}

	seen := make(map[string]struct{}, len(children))
	for _, child := range children {
		if _, exists := seen[child]; exists {
			return nil, errors.New("child names must be unique")
		}
		seen[child] = struct{}{}
	}

	garden := &Garden{plants: make(map[string][]string, len(children))}
	for i, child := range children {
		cupIndexes := []int{2 * i, 2*i + 1, 2 * i, 2*i + 1}
		rowIndexes := []int{0, 0, 1, 1}
		plants := make([]string, 0, 4)
		for j, col := range cupIndexes {
			plant, ok := plantNames[rows[rowIndexes[j]][col]]
			if !ok {
				return nil, errors.New("diagram contains an invalid plant code")
			}
			plants = append(plants, plant)
		}
		garden.plants[child] = plants
	}
	return garden, nil
}

func (g *Garden) Plants(child string) ([]string, bool) {
	plants, ok := g.plants[child]
	if !ok {
		return nil, false
	}
	return append([]string(nil), plants...), true
}
