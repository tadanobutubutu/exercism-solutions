defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true

  def chain?(dominoes) do
    {degrees, adjacency} =
      Enum.reduce(dominoes, {%{}, %{}}, fn {left, right}, {degrees, adjacency} ->
        degrees =
          degrees
          |> Map.update(left, 1, &(&1 + 1))
          |> Map.update(right, 1, &(&1 + 1))

        adjacency =
          adjacency
          |> Map.update(left, [right], &[right | &1])
          |> Map.update(right, [left], &[left | &1])

        {degrees, adjacency}
      end)

    Enum.all?(degrees, fn {_pip, degree} -> rem(degree, 2) == 0 end) and
      connected?(adjacency)
  end

  defp connected?(adjacency) do
    [start | _] = Map.keys(adjacency)
    visit([start], adjacency, MapSet.new()) |> MapSet.size() == map_size(adjacency)
  end

  defp visit([], _adjacency, visited), do: visited

  defp visit([pip | rest], adjacency, visited) do
    if MapSet.member?(visited, pip) do
      visit(rest, adjacency, visited)
    else
      neighbors = Map.fetch!(adjacency, pip)
      visit(neighbors ++ rest, adjacency, MapSet.put(visited, pip))
    end
  end
end
