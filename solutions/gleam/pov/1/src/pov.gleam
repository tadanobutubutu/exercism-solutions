import gleam/list

pub type Tree(a) {
  Tree(label: a, children: List(Tree(a)))
}

type Context(a) {
  Context(label: a, siblings: List(Tree(a)))
}

pub fn from_pov(tree: Tree(a), from: a) -> Result(Tree(a), Nil) {
  case find_target(tree, from) {
    None -> Error(Nil)
    Some(#(target, contexts)) -> Ok(reroot_from_path(target, contexts))
  }
}

pub fn path_to(
  tree tree: Tree(a),
  from from: a,
  to to: a,
) -> Result(List(a), Nil) {
  case from_pov(tree, from) {
    Error(_) -> Error(Nil)
    Ok(rerooted) -> case find_path(rerooted, to) {
      None -> Error(Nil)
      Some(path) -> Ok(path)
    }
  }
}

fn find_target(tree: Tree(a), target: a) -> Option(#(Tree(a), List(Context(a)))) {
  case tree {
    Tree(label, children) -> case label == target {
      True -> Some(#(tree, []))
      False -> find_in_children(children, label, target, [])
    }
  }
}

fn find_in_children(
  remaining: List(Tree(a)),
  parent_label: a,
  target: a,
  preceding_reversed: List(Tree(a)),
) -> Option(#(Tree(a), List(Context(a)))) {
  case remaining {
    [] -> None
    [child, ..rest] -> case find_target(child, target) {
      Some(#(found, contexts)) -> {
        let siblings = list.append(list.reverse(preceding_reversed), rest)
        Some(#(found, list.append(contexts, [Context(parent_label, siblings)])))
      }
      None -> find_in_children(rest, parent_label, target, [child, ..preceding_reversed])
    }
  }
}

fn reroot_from_path(target: Tree(a), contexts: List(Context(a))) -> Tree(a) {
  case target {
    Tree(label, children) -> case contexts {
      [] -> target
      [first, ..rest] -> Tree(label, list.append(children, [build_ancestors(first, rest)]))
    }
  }
}

fn build_ancestors(first: Context(a), rest: List(Context(a))) -> Tree(a) {
  case first {
    Context(label, siblings) -> case rest {
      [] -> Tree(label, siblings)
      [next, ..remaining] -> Tree(label, list.append(siblings, [build_ancestors(next, remaining)]))
    }
  }
}

fn find_path(tree: Tree(a), target: a) -> Option(List(a)) {
  case tree {
    Tree(label, children) -> case label == target {
      True -> Some([label])
      False -> find_path_in_children(children, label, target)
    }
  }
}

fn find_path_in_children(children: List(Tree(a)), parent: a, target: a) -> Option(List(a)) {
  case children {
    [] -> None
    [child, ..rest] -> case find_path(child, target) {
      Some(path) -> Some([parent, ..path])
      None -> find_path_in_children(rest, parent, target)
    }
  }
}
