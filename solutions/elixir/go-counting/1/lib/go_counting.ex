defmodule GoCounting do
  @type position :: {integer, integer}
  @type owner :: %{owner: atom, territory: [position]}
  @type territories :: %{white: [position], black: [position], none: [position]}

  @doc """
  Return the owner and territory around a position
  """
  @spec territory(board :: String.t(), position :: position) ::
          {:ok, owner} | {:error, String.t()}
  def territory(board, {x, y} = pos) do
    grid = parse_board(board)
    height = length(grid)
    width = grid |> List.first([]) |> length()

    if x < 0 or y < 0 or x >= width or y >= height do
      {:error, "Invalid coordinate"}
    else
      if cell(grid, pos) != ?_ do
        {:ok, %{owner: :none, territory: []}}
      else
        {region, borders} = explore(grid, [pos], MapSet.new(), MapSet.new())
        {:ok, %{owner: owner(borders), territory: Enum.sort(region)}}
      end
    end
  end

  @doc """
  Return all white, black and neutral territories
  """
  @spec territories(board :: String.t()) :: territories
  def territories(board) do
    grid = parse_board(board)
    height = length(grid)
    width = grid |> List.first([]) |> length()

    positions = for y <- 0..(height - 1), x <- 0..(width - 1), do: {x, y}

    {territories, _visited} =
      Enum.reduce(positions, {%{black: [], white: [], none: []}, MapSet.new()}, fn pos,
                                                                                   {territories,
                                                                                    visited} ->
        if MapSet.member?(visited, pos) or cell(grid, pos) != ?_ do
          {territories, visited}
        else
          {region, borders} = explore(grid, [pos], MapSet.new(), MapSet.new())
          territory_owner = owner(borders)

          {Map.update!(territories, territory_owner, &(&1 ++ region)),
           MapSet.union(visited, MapSet.new(region))}
        end
      end)

    Map.new(territories, fn {territory_owner, points} -> {territory_owner, Enum.sort(points)} end)
  end

  defp parse_board(board) do
    board
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end

  defp explore(_grid, [], region, borders), do: {MapSet.to_list(region), borders}

  defp explore(grid, [{x, y} = pos | rest], region, borders) do
    if outside?(grid, pos) do
      explore(grid, rest, region, borders)
    else
      case cell(grid, pos) do
        ?_ ->
          if MapSet.member?(region, pos) do
            explore(grid, rest, region, borders)
          else
            neighbors = [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
            explore(grid, neighbors ++ rest, MapSet.put(region, pos), borders)
          end

        ?B ->
          explore(grid, rest, region, MapSet.put(borders, :black))

        ?W ->
          explore(grid, rest, region, MapSet.put(borders, :white))
      end
    end
  end

  defp outside?(grid, {x, y}) do
    y < 0 or y >= length(grid) or x < 0 or x >= length(Enum.at(grid, y))
  end

  defp cell(grid, {x, y}), do: grid |> Enum.at(y) |> Enum.at(x)

  defp owner(borders) do
    case MapSet.to_list(borders) do
      [:black] -> :black
      [:white] -> :white
      _ -> :none
    end
  end
end
