package satellite

import "errors"

type Node struct {
	Value string
	Left  *Node
	Right *Node
}

func TreeFromTraversals(preorder, inorder []string) (*Node, error) {
	if len(preorder) != len(inorder) {
		return nil, errors.New("traversals must have the same length")
	}
	if len(preorder) == 0 {
		return nil, nil
	}

	positions := make(map[string]int, len(inorder))
	for index, value := range inorder {
		if _, exists := positions[value]; exists {
			return nil, errors.New("traversals must contain unique items")
		}
		positions[value] = index
	}
	seen := make(map[string]struct{}, len(preorder))
	for _, value := range preorder {
		if _, exists := seen[value]; exists {
			return nil, errors.New("traversals must contain unique items")
		}
		seen[value] = struct{}{}
		if _, exists := positions[value]; !exists {
			return nil, errors.New("traversals must have the same elements")
		}
	}
	if len(seen) != len(positions) {
		return nil, errors.New("traversals must have the same elements")
	}

	preIndex := 0
	var build func(int, int) (*Node, error)
	build = func(low, high int) (*Node, error) {
		if low > high {
			return nil, nil
		}
		if preIndex >= len(preorder) {
			return nil, errors.New("traversals are inconsistent")
		}
		value := preorder[preIndex]
		preIndex++
		middle, exists := positions[value]
		if !exists || middle < low || middle > high {
			return nil, errors.New("traversals are inconsistent")
		}
		left, err := build(low, middle-1)
		if err != nil {
			return nil, err
		}
		right, err := build(middle+1, high)
		if err != nil {
			return nil, err
		}
		return &Node{Value: value, Left: left, Right: right}, nil
	}
	return build(0, len(inorder)-1)
}
