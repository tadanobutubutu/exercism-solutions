package sgfparsing

import (
	"errors"
	"unicode"
)

// Node represents an SGF node with properties and child nodes.
type Node struct {
	Properties map[string][]string
	Children   []*Node
}

// Parse decodes an SGF string and returns the root node of the tree.
func Parse(encoded string) (*Node, error) {
	if encoded == "" || encoded[0] != '(' {
		return nil, errors.New("tree missing")
	}
	p := parser{input: []rune(encoded)}
	root, err := p.collection()
	if err != nil {
		return nil, err
	}
	if p.position != len(p.input) {
		return nil, errors.New("invalid SGF syntax")
	}
	return root, nil
}

type parser struct {
	input    []rune
	position int
}

func (p *parser) collection() (*Node, error) {
	if !p.take('(') {
		return nil, errors.New("tree missing")
	}
	if p.peek() == ')' {
		return nil, errors.New("tree with no nodes")
	}
	root, tail, err := p.sequence()
	if err != nil {
		return nil, err
	}
	for p.peek() == '(' {
		child, err := p.collection()
		if err != nil {
			return nil, err
		}
		tail.Children = append(tail.Children, child)
	}
	if !p.take(')') {
		return nil, errors.New("invalid SGF syntax")
	}
	return root, nil
}

func (p *parser) sequence() (*Node, *Node, error) {
	var root, tail *Node
	for p.peek() == ';' {
		p.position++
		node, err := p.node()
		if err != nil {
			return nil, nil, err
		}
		if root == nil {
			root = node
		} else {
			tail.Children = append(tail.Children, node)
		}
		tail = node
	}
	if root == nil {
		return nil, nil, errors.New("tree with no nodes")
	}
	return root, tail, nil
}

func (p *parser) node() (*Node, error) {
	node := &Node{Properties: make(map[string][]string), Children: []*Node{}}
	for isLetter(p.peek()) {
		start := p.position
		for isLetter(p.peek()) {
			if p.peek() >= 'a' && p.peek() <= 'z' {
				return nil, errors.New("property must be in uppercase")
			}
			p.position++
		}
		key := string(p.input[start:p.position])
		if p.peek() != '[' {
			return nil, errors.New("properties without delimiter")
		}
		if _, exists := node.Properties[key]; exists {
			return nil, errors.New("property must not be repeated")
		}
		for p.peek() == '[' {
			value, err := p.value()
			if err != nil {
				return nil, err
			}
			node.Properties[key] = append(node.Properties[key], value)
		}
	}
	return node, nil
}

func (p *parser) value() (string, error) {
	p.position++ // opening '['
	var value []rune
	for p.position < len(p.input) {
		character := p.input[p.position]
		p.position++
		if character == ']' {
			return string(value), nil
		}
		if character == '\\' {
			if p.position >= len(p.input) {
				break
			}
			escaped := p.input[p.position]
			p.position++
			if escaped == '\n' {
				continue
			}
			if unicode.IsSpace(escaped) {
				value = append(value, ' ')
			} else {
				value = append(value, escaped)
			}
			continue
		}
		if character != '\n' && unicode.IsSpace(character) {
			value = append(value, ' ')
		} else {
			value = append(value, character)
		}
	}
	return "", errors.New("unterminated property value")
}

func (p *parser) peek() rune {
	if p.position >= len(p.input) {
		return 0
	}
	return p.input[p.position]
}

func (p *parser) take(expected rune) bool {
	if p.peek() != expected {
		return false
	}
	p.position++
	return true
}

func isLetter(character rune) bool {
	return character >= 'A' && character <= 'Z' || character >= 'a' && character <= 'z'
}
