pub type GbTree(key, value)

@external(erlang, "gb_trees", "empty")
pub fn new_gb_tree() -> GbTree(k, v)

@external(erlang, "gb_trees", "insert")
pub fn insert(tree: GbTree(k, v), key: k, value: v) -> GbTree(k, v)

@external(erlang, "gb_trees", "delete_any")
pub fn delete(tree: GbTree(k, v), key: k) -> GbTree(k, v)
