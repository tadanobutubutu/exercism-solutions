from json import dumps


class Tree:
    def __init__(self, label, children=None):
        self.label = label
        self.children = children if children is not None else []

    def __dict__(self):
        return {self.label: [c.__dict__() for c in sorted(self.children)]}

    def __str__(self, indent=None):
        return dumps(self.__dict__(), indent=indent)

    def __lt__(self, other):
        return self.label < other.label

    def __eq__(self, other):
        return self.__dict__() == other.__dict__()

    def from_pov(self, from_node):
        """Re-root the tree at a specific node.
        
        Args:
            from_node: The label of the node to make the new root
            
        Returns:
            A new tree rooted at from_node
            
        Raises:
            ValueError: If from_node is not in the tree
        """
        # Find the path from root to from_node
        path = self._find_path(from_node)
        if path is None:
            raise ValueError("Tree could not be reoriented")
        
        # Re-root: reverse the path and restructure
        return self._reroot(path)
    
    def path_to(self, from_node, to_node):
        """Find the path from from_node to to_node.
        
        Args:
            from_node: Starting node label
            to_node: Ending node label
            
        Returns:
            List of node labels representing the path
            
        Raises:
            ValueError: If either node is not in tree or no path exists
        """
        # First, verify from_node exists
        if self._find_path(from_node) is None:
            raise ValueError("Tree could not be reoriented")
        
        # Check if to_node exists
        if self._find_path(to_node) is None:
            raise ValueError("No path found")
        
        # Re-root at from_node
        from_root = self.from_pov(from_node)
        
        # Now find path to to_node in this re-rooted tree
        path = from_root._find_path_from_root(to_node)
        if path is None:
            raise ValueError("No path found")
        
        return path
    
    def _find_path(self, target):
        """Find the path from this node to target node.
        
        Returns the path as a list of nodes,
        or None if not found.
        """
        if self.label == target:
            return [self]
        
        for child in self.children:
            path = child._find_path(target)
            if path is not None:
                return [self] + path
        
        return None
    
    def _find_path_from_root(self, target):
        """Find path from this root node to target (as list of labels)."""
        if self.label == target:
            return [self.label]
        
        for child in self.children:
            path = child._find_path_from_root(target)
            if path is not None:
                return [self.label] + path
        
        return None
    
    def _reroot(self, path):
        """Re-root the tree using the given path.
        
        path: List of nodes from root to from_node
        The new root should be path[-1]
        """
        if len(path) == 1:
            # Already at the node we want - just return a copy with its children
            return Tree(path[0].label, list(path[0].children))
        
        # Build the new tree from bottom up
        # Start with the target node as the new root
        new_root = Tree(path[-1].label, list(path[-1].children))
        
        # Walk backwards from parent to root, reversing relationships
        current = new_root
        for i in range(len(path) - 2, -1, -1):
            parent_node = path[i]
            # Get siblings (all children except the one we came from)
            siblings = [child for child in parent_node.children if child.label != path[i + 1].label]
            # Create new parent node with siblings + current
            parent = Tree(parent_node.label, siblings + [current])
            current = parent
        
        # Return the new root (which is at path[-1])
        # We need to go back down to find the actual root
        # The root is still new_root, but wrapped with parents
        # Actually, we built this backwards - current is now the top level
        # But we want new_root at the top!
        
        # Let me rebuild: attach as children of new_root instead
        new_root = Tree(path[-1].label, list(path[-1].children))
        current = new_root
        
        for i in range(len(path) - 2, -1, -1):
            parent_node = path[i]
            siblings = [child for child in parent_node.children if child.label != path[i + 1].label]
            current.children.append(Tree(parent_node.label, siblings))
            current = current.children[-1]
        
        return new_root
