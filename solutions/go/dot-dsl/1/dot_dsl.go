package dotdsl

import (
	"errors"
	"strconv"
	"strings"
)

// Properties holds the properties of a node or edge.
// The values can be int, bool or string.
type Properties map[string]any

// Graph stores the parts of a dot graph.
// All entities are stored as a Properties map (`nil` Properties when none set)
// attrs is the Properties for the entire Graph, vs a specific node or edge.
type Graph struct {
	nodes map[string]Properties
	edges map[string]Properties
	attrs Properties
}

// Parse creates a Graph from a text blob.
func Parse(data string) (*Graph, error) {
	p := parser{input: data}
	first := p.next()
	if first.text != "graph" || first.quoted || p.next().text != "{" {
		return nil, errors.New("invalid graph")
	}
	graph := &Graph{}
	for {
		token := p.next()
		if token.text == "}" && !token.quoted {
			if p.next().text != "" {
				return nil, errors.New("invalid graph")
			}
			return graph, nil
		}
		if token.text == "" {
			return nil, errors.New("invalid graph")
		}
		if token.text == ";" {
			continue
		}
		if token.text == "[" {
			attrs, err := p.attributes()
			if err != nil {
				return nil, err
			}
			graph.attrs = merge(graph.attrs, attrs)
			if !p.endStatement() {
				return nil, errors.New("invalid attribute")
			}
			continue
		}
		if token.quoted || !validName(token.text) {
			return nil, errors.New("node name must be alphanumeric")
		}
		left := token.text
		p.ensureNode(graph, left)
		next := p.next()
		if next.text == "--" {
			nodes := []string{left}
			for {
				node := p.next()
				if node.text == "" || node.text == "--" || node.text == ";" || node.text == "}" || node.quoted || !validName(node.text) {
					return nil, errors.New("invalid edge")
				}
				nodes = append(nodes, node.text)
				connector := p.next()
				if connector.text != "--" {
					next = connector
					break
				}
			}
			var attrs Properties
			if next.text == "[" {
				var err error
				attrs, err = p.attributes()
				if err != nil {
					return nil, err
				}
			} else if next.text != ";" && next.text != "}" && next.text != "" {
				return nil, errors.New("invalid edge")
			}
			for i := 1; i < len(nodes); i++ {
				p.ensureNode(graph, nodes[i])
				key := edgeKey(nodes[i-1], nodes[i])
				if graph.edges == nil {
					graph.edges = make(map[string]Properties)
				}
				graph.edges[key] = merge(graph.edges[key], attrs)
			}
			if next.text == "[" && !p.endStatement() {
				return nil, errors.New("invalid edge")
			}
			if next.text == "}" {
				p.push(next)
			}
			continue
		}
		if next.text == "[" {
			attrs, err := p.attributes()
			if err != nil {
				return nil, err
			}
			graph.nodes[left] = merge(graph.nodes[left], attrs)
			if !p.endStatement() {
				return nil, errors.New("invalid attribute")
			}
			continue
		}
		if next.text != ";" && next.text != "}" && next.text != "" {
			return nil, errors.New("invalid edge")
		}
		if next.text == "}" {
			p.push(next)
		}
	}
}

type token struct {
	text   string
	quoted bool
}

type parser struct {
	input    string
	position int
	pushed   *token
}

func (p *parser) next() token {
	if p.pushed != nil {
		result := *p.pushed
		p.pushed = nil
		return result
	}
	for p.position < len(p.input) {
		if strings.ContainsRune(" \t\r\n", rune(p.input[p.position])) {
			p.position++
			continue
		}
		if p.input[p.position] == '#' || strings.HasPrefix(p.input[p.position:], "//") {
			for p.position < len(p.input) && p.input[p.position] != '\n' {
				p.position++
			}
			continue
		}
		break
	}
	if p.position >= len(p.input) {
		return token{}
	}
	if strings.HasPrefix(p.input[p.position:], "--") {
		p.position += 2
		return token{text: "--"}
	}
	character := p.input[p.position]
	if strings.ContainsRune("{}[];=,", rune(character)) {
		p.position++
		return token{text: string(character)}
	}
	if character == '"' {
		p.position++
		var value strings.Builder
		for p.position < len(p.input) {
			current := p.input[p.position]
			p.position++
			if current == '"' {
				return token{text: value.String(), quoted: true}
			}
			if current == '\\' && p.position < len(p.input) {
				current = p.input[p.position]
				p.position++
			}
			value.WriteByte(current)
		}
		return token{text: "\x00", quoted: true}
	}
	start := p.position
	for p.position < len(p.input) {
		current := p.input[p.position]
		if strings.ContainsRune(" \t\r\n{}[];=,\"", rune(current)) || current == '#' || strings.HasPrefix(p.input[p.position:], "//") || strings.HasPrefix(p.input[p.position:], "--") {
			break
		}
		p.position++
	}
	if start == p.position {
		p.position++
	}
	return token{text: p.input[start:p.position]}
}

func (p *parser) push(value token) {
	p.pushed = &value
}

func (p *parser) attributes() (Properties, error) {
	attrs := make(Properties)
	for {
		key := p.next()
		if key.text == "]" || key.text == "" || key.text == "=" || key.text == "[" || key.text == "," || key.text == ";" {
			return nil, errors.New("invalid attribute")
		}
		equals := p.next()
		if equals.text != "=" {
			return nil, errors.New("invalid attribute")
		}
		value := p.next()
		if value.text == "" || value.text == "]" || value.text == "," {
			return nil, errors.New("invalid attribute")
		}
		attrs[key.text] = parseValue(value)
		next := p.next()
		if next.text == "]" {
			return attrs, nil
		}
		if next.text != "," {
			return nil, errors.New("invalid attribute")
		}
	}
}

func parseValue(value token) any {
	if value.quoted {
		return value.text
	}
	if parsed, err := strconv.Atoi(value.text); err == nil {
		return parsed
	}
	if parsed, err := strconv.ParseBool(value.text); err == nil {
		return parsed
	}
	return value.text
}

func (p *parser) endStatement() bool {
	next := p.next()
	if next.text == ";" {
		return true
	}
	if next.text == "}" || next.text == "" {
		p.push(next)
		return true
	}
	return false
}

func (p *parser) ensureNode(graph *Graph, name string) {
	if graph.nodes == nil {
		graph.nodes = make(map[string]Properties)
	}
	if _, exists := graph.nodes[name]; !exists {
		graph.nodes[name] = nil
	}
}

func merge(existing, incoming Properties) Properties {
	if len(incoming) == 0 {
		return existing
	}
	merged := make(Properties, len(existing)+len(incoming))
	for key, value := range existing {
		merged[key] = value
	}
	for key, value := range incoming {
		merged[key] = value
	}
	return merged
}

func edgeKey(left, right string) string {
	if left > right {
		left, right = right, left
	}
	return "{" + left + " " + right + "}"
}

func validName(name string) bool {
	if name == "" {
		return false
	}
	for i := range name {
		character := name[i]
		if !(character >= 'a' && character <= 'z' || character >= 'A' && character <= 'Z' || character >= '0' && character <= '9') {
			return false
		}
	}
	return true
}
