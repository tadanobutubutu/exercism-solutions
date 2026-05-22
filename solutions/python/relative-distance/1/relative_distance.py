from collections import deque


class RelativeDistance:
    def __init__(self, family_tree):
        self.family_tree = family_tree
        # Build a bidirectional graph including sibling relationships
        self.graph = {}
        
        # First pass: add parent-child relationships
        for parent, children in family_tree.items():
            if parent not in self.graph:
                self.graph[parent] = set()
            for child in children:
                if child not in self.graph:
                    self.graph[child] = set()
                # Add parent <-> child relationships
                self.graph[parent].add(child)
                self.graph[child].add(parent)
        
        # Second pass: add sibling relationships
        for parent, children in family_tree.items():
            # All children of the same parent are siblings
            for i in range(len(children)):
                for j in range(i + 1, len(children)):
                    child1, child2 = children[i], children[j]
                    self.graph[child1].add(child2)
                    self.graph[child2].add(child1)

    def degree_of_separation(self, person_a, person_b):
        # Check if both people are in the tree
        if person_a not in self.graph:
            raise ValueError("Person A not in family tree.")
        if person_b not in self.graph:
            raise ValueError("Person B not in family tree.")
        
        # If they're the same person, degree of separation is 0
        if person_a == person_b:
            return 0
            
        # BFS to find shortest path
        queue = deque([(person_a, 0)])  # (current_person, distance)
        visited = {person_a}
        
        while queue:
            current_person, distance = queue.popleft()
            
            # Check all neighbors (parents, children, and siblings)
            for neighbor in self.graph.get(current_person, set()):
                if neighbor == person_b:
                    return distance + 1
                
                if neighbor not in visited:
                    visited.add(neighbor)
                    queue.append((neighbor, distance + 1))
        
        # If we get here, there's no connection
        raise ValueError("No connection between person A and person B.")
