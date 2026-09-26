defmodule FlowerField do
  @doc """
  Annotate empty spots next to flowers with the number of flowers next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]

  def annotate(board) do
    rows = Enum.map(board, &String.graphemes/1)
    height = length(rows)

    if height == 0 do
      []
    else
      width = rows |> hd() |> length()

      if width == 0 do
        List.duplicate("", height)
      else

        for row <- 0..(height - 1) do
          for column <- 0..(width - 1) do
            if Enum.at(Enum.at(rows, row), column) == "*" do
              "*"
            else
              count =
                for neighbor_row <- max(0, row - 1)..min(height - 1, row + 1),
                    neighbor_column <- max(0, column - 1)..min(width - 1, column + 1),
                    Enum.at(Enum.at(rows, neighbor_row), neighbor_column) == "*",
                    do: 1

              case length(count) do
                0 -> " "
                amount -> Integer.to_string(amount)
              end
            end
          end
          |> Enum.join()
        end
      end
    end
  end
end
