package dominoes

type Domino [2]int

type adjacent struct {
	vertex int
	edge   int
}

func MakeChain(input []Domino) ([]Domino, bool) {
	if len(input) == 0 {
		return []Domino{}, true
	}
	graph := make(map[int][]adjacent)
	used := make([]bool, len(input))
	for edge, domino := range input {
		left, right := domino[0], domino[1]
		graph[left] = append(graph[left], adjacent{vertex: right, edge: edge})
		graph[right] = append(graph[right], adjacent{vertex: left, edge: edge})
	}

	vertices := make([]int, 0, len(input)+1)
	var visit func(int)
	visit = func(vertex int) {
		for _, next := range graph[vertex] {
			if used[next.edge] {
				continue
			}
			used[next.edge] = true
			visit(next.vertex)
		}
		vertices = append(vertices, vertex)
	}
	visit(input[0][0])
	if len(vertices) != len(input)+1 {
		return nil, false
	}
	for left, right := 0, len(vertices)-1; left < right; left, right = left+1, right-1 {
		vertices[left], vertices[right] = vertices[right], vertices[left]
	}
	chain := make([]Domino, 0, len(input))
	for i := 1; i < len(vertices); i++ {
		chain = append(chain, Domino{vertices[i-1], vertices[i]})
	}
	if vertices[0] != vertices[len(vertices)-1] {
		return nil, false
	}
	return chain, true
}
