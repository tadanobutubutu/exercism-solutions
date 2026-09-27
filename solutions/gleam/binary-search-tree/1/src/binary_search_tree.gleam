pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn to_tree(data: List(Int)) -> Tree {
  case data {
    [] -> Nil
    [root, ..rest] -> insert_all(rest, Node(data: root, left: Nil, right: Nil))
  }
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  to_tree(data) |> in_order([])
}

fn insert_all(values: List(Int), tree: Tree) -> Tree {
  case values {
    [] -> tree
    [value, ..rest] -> insert_all(rest, insert(value, tree))
  }
}

fn insert(value: Int, tree: Tree) -> Tree {
  case tree {
    Nil -> Node(data: value, left: Nil, right: Nil)
    Node(data, left, right) ->
      case value <= data {
        True -> Node(data: data, left: insert(value, left), right: right)
        False -> Node(data: data, left: left, right: insert(value, right))
      }
  }
}

fn in_order(tree: Tree, result: List(Int)) -> List(Int) {
  case tree {
    Nil -> result
    Node(data, left, right) -> in_order(left, [data, ..in_order(right, result)])
  }
}
