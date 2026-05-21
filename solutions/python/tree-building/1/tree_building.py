class Record:
    def __init__(self, record_id, parent_id):
        self.record_id = record_id
        self.parent_id = parent_id


class Node:
    def __init__(self, node_id):
        self.node_id = node_id
        self.children = []


def BuildTree(records):
    if not records:
        return None
    
    # Sort records by ID for validation
    sorted_records = sorted(records, key=lambda r: r.record_id)
    
    # Validate IDs are sequential starting from 0
    for i, record in enumerate(sorted_records):
        if record.record_id != i:
            raise ValueError("Record id is invalid or out of order.")
    
    # Validate root node (ID 0 must have parent_id 0)
    root_record = sorted_records[0]
    if root_record.parent_id != 0:
        raise ValueError("Node parent_id should be smaller than its record_id.")
    
    # Create nodes dict and validate constraints
    nodes = {}
    for record in sorted_records:
        # Each node (except root) can't be its own parent
        if record.record_id == record.parent_id and record.record_id != 0:
            raise ValueError("Only root should have equal record and parent id.")
        
        # Parent ID must be strictly less than node ID (except for root)
        if record.record_id != record.parent_id and record.parent_id > record.record_id:
            raise ValueError("Node parent_id should be smaller than its record_id.")
        
        # Create node
        nodes[record.record_id] = Node(record.record_id)
    
    # Build the tree by connecting nodes to their parents
    for record in sorted_records:
        if record.record_id != 0:
            parent_node = nodes[record.parent_id]
            child_node = nodes[record.record_id]
            parent_node.children.append(child_node)
    
    return nodes[0]
