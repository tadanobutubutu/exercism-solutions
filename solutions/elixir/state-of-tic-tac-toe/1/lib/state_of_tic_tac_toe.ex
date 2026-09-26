defmodule StateOfTicTacToe do
  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """
  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
    rows =
      board
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.trim(&1) |> String.graphemes()))

    cells = Enum.join(rows)

    cond do
      length(rows) != 3 or Enum.any?(rows, &(length(&1) != 3)) or
          not Regex.match?(~r/^[XO.]{9}$/, cells) ->
        {:error, "Invalid board"}

      true ->
        evaluate(rows, cells)
    end
  end

  defp evaluate(rows, cells) do
    x_count = String.graphemes(cells) |> Enum.count(&(&1 == "X"))
    o_count = String.graphemes(cells) |> Enum.count(&(&1 == "O"))
    x_won? = winner?(rows, "X")
    o_won? = winner?(rows, "O")

    cond do
      x_count < o_count -> {:error, "Wrong turn order: O started"}
      x_count > o_count + 1 -> {:error, "Wrong turn order: X went twice"}
      x_won? and o_won? -> impossible_game()
      x_won? and x_count != o_count + 1 -> impossible_game()
      o_won? and x_count != o_count -> impossible_game()
      x_won? or o_won? -> {:ok, :win}
      not String.contains?(cells, ".") -> {:ok, :draw}
      true -> {:ok, :ongoing}
    end
  end

  defp winner?(rows, mark) do
    columns = for column <- 0..2, do: Enum.map(rows, &Enum.at(&1, column))

    diagonals = [
      [Enum.at(Enum.at(rows, 0), 0), Enum.at(Enum.at(rows, 1), 1), Enum.at(Enum.at(rows, 2), 2)],
      [Enum.at(Enum.at(rows, 0), 2), Enum.at(Enum.at(rows, 1), 1), Enum.at(Enum.at(rows, 2), 0)]
    ]

    (rows ++ columns ++ diagonals)
    |> Enum.any?(&Enum.all?(&1, fn cell -> cell == mark end))
  end

  defp impossible_game do
    {:error, "Impossible board: game should have ended after the game was won"}
  end
end
