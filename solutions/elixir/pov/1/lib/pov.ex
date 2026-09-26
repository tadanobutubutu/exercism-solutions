defmodule Pov do
  @typedoc """
  A tree, which is made of a node with several branches
  """
  @type tree :: {any, [tree]}

  @doc """
  Reparent a tree on a selected node.
  """
  @spec from_pov(tree :: tree, node :: any) :: {:ok, tree} | {:error, atom}
  def from_pov(tree, node) do
    graph = to_graph(tree, %{})

    if Map.has_key?(graph, node) do
      {:ok, build_tree(node, nil, graph)}
    else
      {:error, :nonexistent_target}
    end
  end

  @doc """
  Finds a path between two nodes
  """
  @spec path_between(tree :: tree, from :: any, to :: any) :: {:ok, [any]} | {:error, atom}
  def path_between(tree, from, to) do
    from_path = find_path(tree, from)
    to_path = find_path(tree, to)

    cond do
      is_nil(from_path) ->
        {:error, :nonexistent_source}

      is_nil(to_path) ->
        {:error, :nonexistent_destination}

      true ->
        common_count =
          Enum.zip(from_path, to_path)
          |> Enum.take_while(fn {left, right} -> left == right end)
          |> length()

        common_ancestor = Enum.at(from_path, common_count - 1)
        left_side = from_path |> Enum.drop(common_count) |> Enum.reverse()
        right_side = Enum.drop(to_path, common_count)
        {:ok, left_side ++ [common_ancestor] ++ right_side}
    end
  end

  defp to_graph({node, children}, graph) do
    graph = Map.put_new(graph, node, [])

    Enum.reduce(children, graph, fn {child, _grandchildren} = child_tree, graph ->
      graph = Map.update!(graph, node, &(&1 ++ [child]))
      graph = Map.update(graph, child, [node], &(&1 ++ [node]))
      to_graph(child_tree, graph)
    end)
  end

  defp build_tree(node, parent, graph) do
    children =
      graph[node]
      |> Enum.reject(&(&1 == parent))
      |> Enum.map(&build_tree(&1, node, graph))

    {node, children}
  end

  defp find_path({node, _children}, node), do: [node]

  defp find_path({node, children}, target) do
    case Enum.find_value(children, &find_path(&1, target)) do
      nil -> nil
      path -> [node | path]
    end
  end
end
