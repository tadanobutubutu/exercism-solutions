package zipper

import "errors"

type Node struct {
	value int
	left  *Node
	right *Node
}

type Zipper struct {
	focus *Node
	path  []crumb
}

type crumb struct {
	parent    *Node
	child     *Node
	fromRight bool
}

func NewZipper(tree *Node) Zipper {
	return Zipper{focus: tree}
}

func (z Zipper) Value() int {
	if z.focus == nil {
		return 0
	}
	return z.focus.value
}

func (z Zipper) ToTree() *Node {
	node := z.focus
	for i := len(z.path) - 1; i >= 0; i-- {
		step := z.path[i]
		if node == step.child {
			node = step.parent
			continue
		}
		parent := *step.parent
		if step.fromRight {
			parent.right = node
		} else {
			parent.left = node
		}
		node = &parent
	}
	return node
}

func (z Zipper) Left() (Zipper, error) {
	if z.focus == nil || z.focus.left == nil {
		return z, errors.New("no left node")
	}
	path := append(append([]crumb(nil), z.path...), crumb{parent: z.focus, child: z.focus.left})
	return Zipper{focus: z.focus.left, path: path}, nil
}

func (z Zipper) Right() (Zipper, error) {
	if z.focus == nil || z.focus.right == nil {
		return z, errors.New("no right node")
	}
	path := append(append([]crumb(nil), z.path...), crumb{parent: z.focus, child: z.focus.right, fromRight: true})
	return Zipper{focus: z.focus.right, path: path}, nil
}

func (z Zipper) Up() (Zipper, error) {
	if len(z.path) == 0 {
		return z, errors.New("already at root")
	}
	step := z.path[len(z.path)-1]
	parent := step.parent
	if z.focus != step.child {
		copy := *parent
		if step.fromRight {
			copy.right = z.focus
		} else {
			copy.left = z.focus
		}
		parent = &copy
	}
	path := append([]crumb(nil), z.path[:len(z.path)-1]...)
	return Zipper{focus: parent, path: path}, nil
}

func (z Zipper) SetValue(v int) Zipper {
	if z.focus == nil {
		return z
	}
	copy := *z.focus
	copy.value = v
	z.focus = &copy
	return z
}

func (z Zipper) SetLeft(v *Node) Zipper {
	if z.focus == nil {
		return z
	}
	copy := *z.focus
	copy.left = v
	z.focus = &copy
	return z
}

func (z Zipper) SetRight(v *Node) Zipper {
	if z.focus == nil {
		return z
	}
	copy := *z.focus
	copy.right = v
	z.focus = &copy
	return z
}
