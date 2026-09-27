package treebuilding

import "fmt"

type Record struct {
	ID     int
	Parent int
}

type Node struct {
	ID       int
	Children []*Node
}

func Build(records []Record) (*Node, error) {
	if len(records) == 0 {
		return nil, nil
	}

	nodes := make([]*Node, len(records))
	parents := make([]int, len(records))
	seen := make([]bool, len(records))
	for _, record := range records {
		if record.ID < 0 || record.ID >= len(records) {
			return nil, fmt.Errorf("node id %d is out of range", record.ID)
		}
		if seen[record.ID] {
			return nil, fmt.Errorf("duplicate node id %d", record.ID)
		}
		seen[record.ID] = true
		if record.Parent < 0 || record.Parent >= len(records) {
			return nil, fmt.Errorf("parent id %d is out of range", record.Parent)
		}
		if record.ID == 0 {
			if record.Parent != 0 {
				return nil, fmt.Errorf("root node must be its own parent")
			}
		} else if record.Parent >= record.ID {
			return nil, fmt.Errorf("parent id must be lower than node id")
		}
		nodes[record.ID] = &Node{ID: record.ID}
		parents[record.ID] = record.Parent
	}

	for id, exists := range seen {
		if !exists {
			return nil, fmt.Errorf("missing node id %d", id)
		}
	}
	if parents[0] != 0 {
		return nil, fmt.Errorf("tree has no valid root")
	}
	for id := 1; id < len(nodes); id++ {
		parent := parents[id]
		nodes[parent].Children = append(nodes[parent].Children, nodes[id])
	}
	return nodes[0], nil
}
