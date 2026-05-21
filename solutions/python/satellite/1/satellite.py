def tree_from_traversals(preorder, inorder):
    if len(preorder) != len(inorder):
        raise ValueError("traversals must have the same length")
    if set(preorder) != set(inorder):
        raise ValueError("traversals must have the same elements")
    if len(preorder) != len(set(preorder)):
        raise ValueError("traversals must contain unique items")
        
    if not preorder:
        return {}

    def build_tree(pre_part, in_part):
        if not pre_part:
            return {}
        
        root = pre_part[0]
        # In case the items in preorder are not in inorder
        if root not in in_part:
            raise ValueError("traversals must have the same elements")
            
        root_idx = in_part.index(root)
        
        left_inorder = in_part[:root_idx]
        right_inorder = in_part[root_idx + 1:]
        
        left_preorder = pre_part[1:1 + len(left_inorder)]
        right_preorder = pre_part[1 + len(left_inorder):]
        
        return {
            "v": root,
            "l": build_tree(left_preorder, left_inorder),
            "r": build_tree(right_preorder, right_inorder)
        }
        
    return build_tree(preorder, inorder)
