package linkedlist

import (
	"errors"
	"reflect"
)

var errEmptyList = errors.New("cannot remove an item from an empty list")

// Node is one element in a doubly linked list.
type Node struct {
	Value any
	next  *Node
	prev  *Node
}

// List stores the first and last nodes of a sequence.
type List struct {
	head *Node
	tail *Node
	len  int
}

func NewList(elements ...any) *List {
	list := &List{}
	for _, value := range elements {
		list.Push(value)
	}
	return list
}

func (n *Node) Next() *Node {
	if n == nil {
		return nil
	}
	return n.next
}

func (n *Node) Prev() *Node {
	if n == nil {
		return nil
	}
	return n.prev
}

func (l *List) Unshift(v any) {
	node := &Node{Value: v, next: l.head}
	if l.head == nil {
		l.tail = node
	} else {
		l.head.prev = node
	}
	l.head = node
	l.len++
}

func (l *List) Push(v any) {
	node := &Node{Value: v, prev: l.tail}
	if l.tail == nil {
		l.head = node
	} else {
		l.tail.next = node
	}
	l.tail = node
	l.len++
}

func (l *List) Shift() (any, error) {
	if l.head == nil {
		return nil, errEmptyList
	}
	node := l.head
	l.head = node.next
	if l.head == nil {
		l.tail = nil
	} else {
		l.head.prev = nil
	}
	node.next = nil
	l.len--
	return node.Value, nil
}

func (l *List) Pop() (any, error) {
	if l.tail == nil {
		return nil, errEmptyList
	}
	node := l.tail
	l.tail = node.prev
	if l.tail == nil {
		l.head = nil
	} else {
		l.tail.next = nil
	}
	node.prev = nil
	l.len--
	return node.Value, nil
}

func (l *List) Reverse() {
	for node := l.head; node != nil; {
		next := node.next
		node.next, node.prev = node.prev, node.next
		node = next
	}
	l.head, l.tail = l.tail, l.head
}

func (l *List) First() *Node { return l.head }

func (l *List) Last() *Node { return l.tail }

func (l *List) Count() int { return l.len }

// Delete removes the first node in a list with a given value.
// Returns true if a node was removed.
func (l *List) Delete(v any) bool {
	for node := l.head; node != nil; node = node.next {
		if !reflect.DeepEqual(node.Value, v) {
			continue
		}

		if node.prev == nil {
			l.head = node.next
		} else {
			node.prev.next = node.next
		}
		if node.next == nil {
			l.tail = node.prev
		} else {
			node.next.prev = node.prev
		}
		node.next, node.prev = nil, nil
		l.len--
		return true
	}
	return false
}
