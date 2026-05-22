class SgfTree:
    def __init__(self, properties=None, children=None):
        self.properties = properties or {}
        self.children = children or []

    def __eq__(self, other):
        if not isinstance(other, SgfTree):
            return False
        for key, value in self.properties.items():
            if key not in other.properties:
                return False
            if other.properties[key] != value:
                return False
        for key in other.properties.keys():
            if key not in self.properties:
                return False
        if len(self.children) != len(other.children):
            return False
        for child, other_child in zip(self.children, other.children):
            if child != other_child:
                return False
        return True

    def __ne__(self, other):
        return not self == other


def parse(input_string):
    """Parse an SGF string and return the tree structure."""
    if not input_string:
        raise ValueError("tree missing")
    
    input_string = input_string.strip()
    
    # Must start with (
    if not input_string or input_string[0] != '(':
        raise ValueError("tree missing")
    
    parser = SgfParser(input_string)
    try:
        tree = parser.parse_tree()
        if parser.pos < len(input_string):
            raise ValueError("unexpected content after tree")
        return tree
    except IndexError:
        raise ValueError("incomplete tree")


class SgfParser:
    def __init__(self, input_string):
        self.input = input_string
        self.pos = 0
    
    def parse_tree(self):
        """Parse a complete SGF tree: (node+)"""
        self._expect('(')
        nodes = self._parse_nodes()
        self._expect(')')
        
        if not nodes:
            raise ValueError("tree with no nodes")
        
        # Build tree from nodes
        root = nodes[0]
        current = root
        for node in nodes[1:]:
            current.children.append(node)
            current = node
        
        return root
    
    def _parse_nodes(self):
        """Parse one or more nodes (;...) and variations"""
        nodes = []
        children_stacks = []
        
        while self.pos < len(self.input) and self.input[self.pos] != ')':
            if self.input[self.pos] == ';':
                node = self._parse_node()
                nodes.append(node)
            elif self.input[self.pos] == '(':
                # Child variation tree
                subtree = self.parse_tree()
                if nodes:
                    nodes[-1].children.append(subtree)
                else:
                    raise ValueError("child tree without parent node")
            else:
                self._skip_whitespace()
        
        return nodes
    
    def _parse_node(self):
        """Parse a single node: ;property+"""
        self._expect(';')
        properties = {}
        
        while self.pos < len(self.input) and self.input[self.pos] not in (';', '(', ')'):
            prop_name, values = self._parse_property()
            properties[prop_name] = values
        
        return SgfTree(properties=properties)
    
    def _parse_property(self):
        """Parse a property: NAME(values)"""
        # Skip whitespace
        self._skip_whitespace()
        
        # Parse property name (uppercase letters)
        if self.pos >= len(self.input):
            raise ValueError("properties without delimiter")
        
        name_start = self.pos
        while self.pos < len(self.input) and self.input[self.pos].isalpha():
            self.pos += 1
        
        if name_start == self.pos:
            raise ValueError("properties without delimiter")
        
        prop_name = self.input[name_start:self.pos]
        
        # Verify all uppercase
        if not prop_name.isupper():
            raise ValueError("property must be in uppercase")
        
        # Skip whitespace
        self._skip_whitespace()
        
        # Parse values: [...]...
        values = []
        while self.pos < len(self.input) and self.input[self.pos] == '[':
            value = self._parse_property_value()
            values.append(value)
            self._skip_whitespace()
        
        if not values:
            raise ValueError("properties without delimiter")
        
        return prop_name, values
    
    def _parse_property_value(self):
        """Parse a property value: [...]"""
        self._expect('[')
        
        value = []
        while self.pos < len(self.input) and self.input[self.pos] != ']':
            char = self.input[self.pos]
            
            if char == '\\':
                # Escape sequence
                self.pos += 1
                if self.pos >= len(self.input):
                    raise ValueError("incomplete escape")
                
                next_char = self.input[self.pos]
                
                if next_char == '\n':
                    # Escaped newline is removed
                    self.pos += 1
                    continue
                elif next_char == '\t':
                    # Escaped tab becomes space
                    value.append(' ')
                    self.pos += 1
                elif next_char in (' ', '\r'):
                    # Escaped whitespace - check rules
                    if next_char == '\n':
                        self.pos += 1
                    else:
                        value.append(' ')
                        self.pos += 1
                else:
                    # Non-whitespace after backslash is inserted as-is
                    value.append(next_char)
                    self.pos += 1
            elif char == '\t':
                # Tab -> space
                value.append(' ')
                self.pos += 1
            elif char in ('\r', '\n'):
                # Newlines stay but carriage returns -> newline
                if char == '\r' and self.pos + 1 < len(self.input) and self.input[self.pos + 1] == '\n':
                    # Windows line ending
                    value.append('\n')
                    self.pos += 2
                else:
                    value.append(char)
                    self.pos += 1
            else:
                value.append(char)
                self.pos += 1
        
        self._expect(']')
        return ''.join(value)
    
    def _expect(self, char):
        """Expect and consume a specific character."""
        self._skip_whitespace()
        if self.pos >= len(self.input) or self.input[self.pos] != char:
            raise ValueError(f"expected '{char}'")
        self.pos += 1
    
    def _skip_whitespace(self):
        """Skip whitespace characters."""
        while self.pos < len(self.input) and self.input[self.pos] in (' ', '\t', '\n', '\r'):
            self.pos += 1
