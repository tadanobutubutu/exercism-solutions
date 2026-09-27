package tournament

import (
	"bufio"
	"fmt"
	"io"
	"sort"
	"strings"
)

type teamStats struct {
	name                string
	played, wins, draws int
	losses, points      int
}

func Tally(reader io.Reader, writer io.Writer) error {
	teams := make(map[string]*teamStats)
	getTeam := func(name string) *teamStats {
		if teams[name] == nil {
			teams[name] = &teamStats{name: name}
		}
		return teams[name]
	}

	scanner := bufio.NewScanner(reader)
	for lineNumber := 1; scanner.Scan(); lineNumber++ {
		line := strings.TrimSpace(scanner.Text())
		if line == "" || strings.HasPrefix(line, "#") {
			continue
		}
		fields := strings.Split(line, ";")
		if len(fields) != 3 || strings.TrimSpace(fields[0]) == "" || strings.TrimSpace(fields[1]) == "" {
			return fmt.Errorf("invalid match on line %d", lineNumber)
		}
		firstName, secondName, result := strings.TrimSpace(fields[0]), strings.TrimSpace(fields[1]), strings.TrimSpace(fields[2])
		first, second := getTeam(firstName), getTeam(secondName)
		first.played++
		second.played++
		switch result {
		case "win":
			first.wins++
			first.points += 3
			second.losses++
		case "loss":
			first.losses++
			second.wins++
			second.points += 3
		case "draw":
			first.draws++
			second.draws++
			first.points++
			second.points++
		default:
			return fmt.Errorf("invalid result %q on line %d", result, lineNumber)
		}
	}
	if err := scanner.Err(); err != nil {
		return err
	}

	ordered := make([]*teamStats, 0, len(teams))
	for _, team := range teams {
		ordered = append(ordered, team)
	}
	sort.Slice(ordered, func(i, j int) bool {
		if ordered[i].points != ordered[j].points {
			return ordered[i].points > ordered[j].points
		}
		return ordered[i].name < ordered[j].name
	})

	if _, err := fmt.Fprintln(writer, "Team                           | MP |  W |  D |  L |  P"); err != nil {
		return err
	}
	for _, team := range ordered {
		if _, err := fmt.Fprintf(writer, "%-30s | %2d | %2d | %2d | %2d | %2d\n", team.name, team.played, team.wins, team.draws, team.losses, team.points); err != nil {
			return err
		}
	}
	return nil
}
