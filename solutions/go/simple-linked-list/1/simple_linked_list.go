package simplelinkedlist

import "errors"

type Element struct {
	value int
	next  *Element
}

type List struct {
	head *Element
	tail *Element
	size int
}

func New(elements []int) *List {
	list := &List{}
	for _, value := range elements {
		list.PushBack(value)
	}
	return list
}

func (l *List) Size() int {
	return l.size
}

func (l *List) Push(element int) {
	l.PushBack(element)
}

func (l *List) Pop() (int, error) {
	if l.tail == nil {
		return 0, errors.New("list is empty")
	}
	value := l.tail.value
	l.size--
	if l.size == 0 {
		l.head = nil
		l.tail = nil
	} else {
		previous := l.head
		for previous.next != l.tail {
			previous = previous.next
		}
		previous.next = nil
		l.tail = previous
	}
	return value, nil
}

func (l *List) Peek() (int, error) {
	if l.tail == nil {
		return 0, errors.New("list is empty")
	}
	return l.tail.value, nil
}

func (l *List) Array() []int {
	result := make([]int, 0, l.size)
	for element := l.head; element != nil; element = element.next {
		result = append(result, element.value)
	}
	return result
}

func (l *List) Reverse() *List {
	reversed := &List{}
	values := l.Array()
	for i := len(values) - 1; i >= 0; i-- {
		reversed.Push(values[i])
	}
	return reversed
}

func (l *List) PushBack(value int) {
	element := &Element{value: value}
	if l.head == nil {
		l.head = element
		l.tail = element
	} else {
		l.tail.next = element
		l.tail = element
	}
	l.size++
}
