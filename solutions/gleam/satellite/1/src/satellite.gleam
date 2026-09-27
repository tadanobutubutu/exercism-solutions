import gleam/list

pub type Tree(a) {
  Nil
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub type Error {
  DifferentLengths
  DifferentItems
  NonUniqueItems
}

pub fn tree_from_traversals(
  inorder inorder: List(a),
  preorder preorder: List(a),
) -> Result(Tree(a), Error) {
  case list.length(inorder) != list.length(preorder) {
    True -> Error(DifferentLengths)
    False -> case has_duplicates(inorder, []) || has_duplicates(preorder, []) {
      True -> Error(NonUniqueItems)
      False -> case same_items(inorder, preorder) {
        False -> Error(DifferentItems)
        True -> build_tree(inorder, preorder)
      }
    }
  }
}

fn build_tree(inorder: List(a), preorder: List(a)) -> Result(Tree(a), Error) {
  case preorder {
    [] -> Ok(Nil)
    [root, ..remaining_preorder] -> case find_index(inorder, root, 0) {
      None -> Error(DifferentItems)
      Some(index) -> {
        let left_inorder = list.take(inorder, index)
        let right_inorder = list.drop(inorder, index + 1)
        let left_preorder = list.take(remaining_preorder, index)
        let right_preorder = list.drop(remaining_preorder, index)
        case build_tree(left_inorder, left_preorder) {
          Error(error) -> Error(error)
          Ok(left) -> case build_tree(right_inorder, right_preorder) {
            Error(error) -> Error(error)
            Ok(right) -> Ok(Node(value: root, left: left, right: right))
          }
        }
      }
    }
  }
}

fn find_index(items: List(a), target: a, index: Int) -> Option(Int) {
  case items {
    [] -> None
    [item, ..rest] -> case item == target {
      True -> Some(index)
      False -> find_index(rest, target, index + 1)
    }
  }
}

fn has_duplicates(items: List(a), seen: List(a)) -> Bool {
  case items {
    [] -> False
    [item, ..rest] -> case contains(seen, item) {
      True -> True
      False -> has_duplicates(rest, [item, ..seen])
    }
  }
}

fn same_items(left: List(a), right: List(a)) -> Bool {
  list.length(left) == list.length(right) && all_in(left, right)
}

fn all_in(items: List(a), candidates: List(a)) -> Bool {
  case items {
    [] -> True
    [item, ..rest] -> contains(candidates, item) && all_in(rest, candidates)
  }
}

fn contains(items: List(a), target: a) -> Bool {
  case items {
    [] -> False
    [item, ..rest] -> item == target || contains(rest, target)
  }
}
