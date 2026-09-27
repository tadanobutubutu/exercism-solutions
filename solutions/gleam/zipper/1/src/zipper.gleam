pub type Tree(a) {
  Leaf
  Node(value: a, left: Tree(a), right: Tree(a))
}

type Context(a) {
  FromLeft(value: a, right: Tree(a))
  FromRight(value: a, left: Tree(a))
}

pub opaque type Zipper(a) {
  Zipper(focus: Tree(a), parents: List(Context(a)))
}

pub fn to_zipper(tree: Tree(a)) -> Zipper(a) {
  Zipper(focus: tree, parents: [])
}

pub fn to_tree(zipper: Zipper(a)) -> Tree(a) {
  case zipper {
    Zipper(focus, parents) -> rebuild(focus, parents)
  }
}

pub fn value(zipper: Zipper(a)) -> Result(a, Nil) {
  case zipper {
    Zipper(focus, _) -> case focus {
      Leaf -> Error(Nil)
      Node(current, _, _) -> Ok(current)
    }
  }
}

pub fn up(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper {
    Zipper(focus, parents) -> case parents {
      [] -> Error(Nil)
      [FromLeft(parent_value, right), ..rest] ->
        Ok(Zipper(focus: Node(parent_value, focus, right), parents: rest))
      [FromRight(parent_value, left), ..rest] ->
        Ok(Zipper(focus: Node(parent_value, left, focus), parents: rest))
    }
  }
}

pub fn left(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper {
    Zipper(focus, parents) -> case focus {
      Leaf -> Error(Nil)
      Node(parent_value, Leaf, _) -> Error(Nil)
      Node(parent_value, left_tree, right_tree) ->
        Ok(Zipper(focus: left_tree, parents: [FromLeft(parent_value, right_tree), ..parents]))
    }
  }
}

pub fn right(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper {
    Zipper(focus, parents) -> case focus {
      Leaf -> Error(Nil)
      Node(parent_value, _, Leaf) -> Error(Nil)
      Node(parent_value, left_tree, right_tree) ->
        Ok(Zipper(focus: right_tree, parents: [FromRight(parent_value, left_tree), ..parents]))
    }
  }
}

pub fn set_value(zipper: Zipper(a), value: a) -> Zipper(a) {
  case zipper {
    Zipper(Leaf, _) -> zipper
    Zipper(Node(_, left_tree, right_tree), parents) ->
      Zipper(focus: Node(value, left_tree, right_tree), parents: parents)
  }
}

pub fn set_left(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zipper {
    Zipper(Leaf, _) -> Error(Nil)
    Zipper(Node(current, _, right_tree), parents) ->
      Ok(Zipper(focus: Node(current, tree, right_tree), parents: parents))
  }
}

pub fn set_right(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zipper {
    Zipper(Leaf, _) -> Error(Nil)
    Zipper(Node(current, left_tree, _), parents) ->
      Ok(Zipper(focus: Node(current, left_tree, tree), parents: parents))
  }
}

fn rebuild(focus: Tree(a), parents: List(Context(a))) -> Tree(a) {
  case parents {
    [] -> focus
    [FromLeft(parent_value, right), ..rest] ->
      rebuild(Node(parent_value, focus, right), rest)
    [FromRight(parent_value, left), ..rest] ->
      rebuild(Node(parent_value, left, focus), rest)
  }
}
