defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(tree, data) do
    if data <= tree.data do
      child = if tree.left == nil, do: new(data), else: insert(tree.left, data)
      %{tree | left: child}
    else
      child = if tree.right == nil, do: new(data), else: insert(tree.right, data)
      %{tree | right: child}
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
    traverse_in_order(tree)
  end

  defp traverse_in_order(nil), do: []

  defp traverse_in_order(tree) do
    traverse_in_order(tree.left) ++ [tree.data] ++ traverse_in_order(tree.right)
  end
end
