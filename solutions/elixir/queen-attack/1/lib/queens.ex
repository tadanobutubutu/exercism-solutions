defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts \\ []) do
    if Enum.any?(opts, fn {color, _position} -> color not in [:white, :black] end) do
      raise ArgumentError, "invalid queen color"
    end

    queens = %__MODULE__{white: Keyword.get(opts, :white), black: Keyword.get(opts, :black)}

    Enum.each([queens.white, queens.black], fn
      nil -> :ok
      {row, column} when row in 0..7 and column in 0..7 -> :ok
      _ -> raise ArgumentError, "invalid queen position"
    end)

    if not is_nil(queens.white) and queens.white == queens.black do
      raise ArgumentError, "queens cannot occupy the same position"
    end

    queens
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    0..7
    |> Enum.map(fn row ->
      0..7
      |> Enum.map(fn column ->
        case {queens.white, queens.black} do
          {{^row, ^column}, _} -> "W"
          {_, {^row, ^column}} -> "B"
          _ -> "_"
        end
      end)
      |> Enum.join(" ")
    end)
    |> Enum.join("\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    case {queens.white, queens.black} do
      {{white_row, white_column}, {black_row, black_column}} ->
        white_row == black_row or white_column == black_column or
          abs(white_row - black_row) == abs(white_column - black_column)

      _ ->
        false
    end
  end
end
