package gocounting

import "errors"

type AllTerritories struct {
	Black [][2]int
	White [][2]int
	None  [][2]int
}

type Game struct {
	board [][]rune // rows are stored from south to north
}

func NewGame(board []string) *Game {
	rows := make([][]rune, len(board))
	for y, line := range board {
		rows[len(board)-1-y] = []rune(line)
	}
	return &Game{board: rows}
}

func (g *Game) Territory(x, y int) (string, [][2]int, error) {
	if !g.valid(x, y) {
		return "", nil, errors.New("invalid coordinate")
	}
	if g.board[y][x] != ' ' {
		return "NONE", [][2]int{}, nil
	}
	owner, territory := g.component(x, y, nil)
	return owner, territory, nil
}

func (g *Game) Territories() AllTerritories {
	result := AllTerritories{Black: [][2]int{}, White: [][2]int{}, None: [][2]int{}}
	visited := make(map[[2]int]bool)
	for y, row := range g.board {
		for x, point := range row {
			coordinate := [2]int{x, y}
			if point != ' ' || visited[coordinate] {
				continue
			}
			owner, territory := g.component(x, y, visited)
			switch owner {
			case "BLACK":
				result.Black = append(result.Black, territory...)
			case "WHITE":
				result.White = append(result.White, territory...)
			default:
				result.None = append(result.None, territory...)
			}
		}
	}
	return result
}

func (g *Game) component(startX, startY int, visited map[[2]int]bool) (string, [][2]int) {
	queue := [][2]int{{startX, startY}}
	component := make([][2]int, 0)
	colors := make(map[rune]bool)
	seen := make(map[[2]int]bool)
	seen[[2]int{startX, startY}] = true
	for len(queue) > 0 {
		point := queue[0]
		queue = queue[1:]
		component = append(component, point)
		if visited != nil {
			visited[point] = true
		}
		for _, direction := range [][2]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}} {
			x, y := point[0]+direction[0], point[1]+direction[1]
			if !g.valid(x, y) {
				continue
			}
			neighbor := [2]int{x, y}
			switch g.board[y][x] {
			case 'B', 'W':
				colors[g.board[y][x]] = true
			case ' ':
				if !seen[neighbor] {
					seen[neighbor] = true
					queue = append(queue, neighbor)
				}
			}
		}
	}
	owner := "NONE"
	if colors['B'] && !colors['W'] {
		owner = "BLACK"
	} else if colors['W'] && !colors['B'] {
		owner = "WHITE"
	}
	return owner, component
}

func (g *Game) valid(x, y int) bool {
	return y >= 0 && y < len(g.board) && x >= 0 && x < len(g.board[y])
}
