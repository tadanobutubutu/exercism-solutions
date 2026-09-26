defmodule Satellite do
  @typedoc """
  A tree, which can be empty, or made from a left branch, a node and a right branch
  """
  @type tree :: {} | {tree, any, tree}

  @doc """
  Build a tree from the elements given in a pre-order and in-order style
  """
  @spec build_tree(preorder :: [any], inorder :: [any]) :: {:ok, tree} | {:error, String.t()}

  def build_tree(preorder, inorder) do
    cond do
      length(preorder) != length(inorder) ->
        {:error, "traversals must have the same length"}

      MapSet.size(MapSet.new(preorder)) != length(preorder) or
          MapSet.size(MapSet.new(inorder)) != length(inorder) ->
        {:error, "traversals must contain unique items"}

      MapSet.new(preorder) != MapSet.new(inorder) ->
        {:error, "traversals must have the same elements"}

      true ->
        build(preorder, inorder)
    end
  end

  defp build([], []), do: {:ok, {}}

  defp build([root | preorder], inorder) do
    root_index = Enum.find_index(inorder, &(&1 == root))

    if is_nil(root_index) do
      {:error, "traversals must have the same elements"}
    else
      {left_inorder, [_root | right_inorder]} = Enum.split(inorder, root_index)
      {left_preorder, right_preorder} = Enum.split(preorder, length(left_inorder))

      if length(right_preorder) != length(right_inorder) do
        {:error, "traversals must have the same elements"}
      else
        with {:ok, left} <- build(left_preorder, left_inorder),
             {:ok, right} <- build(right_preorder, right_inorder) do
          {:ok, {left, root, right}}
        end
      end
    end
  end

  defp build(_preorder, _inorder), do: {:error, "traversals must have the same elements"}
end
