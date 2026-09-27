package pov

type Tree struct {
	value    string
	children []*Tree
}

// New creates and returns a new Tree with the given root value and children.
func New(value string, children ...*Tree) *Tree {
	return &Tree{value: value, children: append([]*Tree(nil), children...)}
}

// Value returns the value at the root of a tree.
func (tr *Tree) Value() string {
	if tr == nil {
		return ""
	}
	return tr.value
}

// Children returns a slice containing the children of a tree.
// There is no need to sort the elements in the result slice,
// they can be in any order.
func (tr *Tree) Children() []*Tree {
	if tr == nil {
		return nil
	}
	return append([]*Tree(nil), tr.children...)
}

// String describes a tree in a compact S-expression format.
// This helps to make test outputs more readable.
// Feel free to adapt this method as you see fit.
func (tr *Tree) String() string {
	if tr == nil {
		return "nil"
	}
	result := tr.Value()
	if len(tr.Children()) == 0 {
		return result
	}
	for _, ch := range tr.Children() {
		result += " " + ch.String()
	}
	return "(" + result + ")"
}

// POV problem-specific functions

// FromPov returns the pov from the node specified in the argument.
func (tr *Tree) FromPov(from string) *Tree {
	if tr == nil {
		return nil
	}
	graph, nodes := tr.graph()
	root := nodes[from]
	if root == nil {
		return nil
	}
	return orient(root, nil, graph)
}

// PathTo returns the shortest path between two nodes in the tree.
func (tr *Tree) PathTo(from, to string) []string {
	if tr == nil {
		return nil
	}
	graph, nodes := tr.graph()
	start, destination := nodes[from], nodes[to]
	if start == nil || destination == nil {
		return nil
	}

	parents := map[*Tree]*Tree{start: nil}
	queue := []*Tree{start}
	for len(queue) > 0 {
		current := queue[0]
		queue = queue[1:]
		if current == destination {
			var path []string
			for node := destination; node != nil; node = parents[node] {
				path = append(path, node.value)
			}
			for left, right := 0, len(path)-1; left < right; left, right = left+1, right-1 {
				path[left], path[right] = path[right], path[left]
			}
			return path
		}
		for _, neighbor := range graph[current] {
			if _, seen := parents[neighbor]; seen {
				continue
			}
			parents[neighbor] = current
			queue = append(queue, neighbor)
		}
	}
	return nil
}

func (tr *Tree) graph() (map[*Tree][]*Tree, map[string]*Tree) {
	graph := make(map[*Tree][]*Tree)
	nodes := make(map[string]*Tree)
	var visit func(*Tree, *Tree)
	visit = func(node, parent *Tree) {
		if node == nil {
			return
		}
		nodes[node.value] = node
		if parent != nil {
			graph[node] = append(graph[node], parent)
			graph[parent] = append(graph[parent], node)
		}
		for _, child := range node.children {
			visit(child, node)
		}
	}
	visit(tr, nil)
	return graph, nodes
}

func orient(node, parent *Tree, graph map[*Tree][]*Tree) *Tree {
	result := &Tree{value: node.value}
	for _, neighbor := range graph[node] {
		if neighbor != parent {
			result.children = append(result.children, orient(neighbor, node, graph))
		}
	}
	return result
}
