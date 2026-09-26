defmodule JigsawPuzzle do
  @doc """
  Fill in missing jigsaw puzzle details from partial data
  """

  @type format() :: :landscape | :portrait | :square
  @type t() :: %__MODULE__{
          pieces: pos_integer() | nil,
          rows: pos_integer() | nil,
          columns: pos_integer() | nil,
          format: format() | nil,
          aspect_ratio: float() | nil,
          border: pos_integer() | nil,
          inside: pos_integer() | nil
        }

  defstruct [:pieces, :rows, :columns, :format, :aspect_ratio, :border, :inside]

  @spec data(jigsaw_puzzle :: JigsawPuzzle.t()) ::
          {:ok, JigsawPuzzle.t()} | {:error, String.t()}
  def data(jigsaw_puzzle) do
    case dimensions(jigsaw_puzzle) do
      [] ->
        {:error, "Contradictory data"}

      [{rows, columns}] ->
        pieces = rows * columns
        border = border_pieces(rows, columns)
        ratio = columns / rows

        {:ok,
         %__MODULE__{
           pieces: pieces,
           rows: rows,
           columns: columns,
           format: format(rows, columns),
           aspect_ratio: ratio,
           border: border,
           inside: pieces - border
         }}

      _multiple ->
        {:error, "Insufficient data"}
    end
  end

  defp dimensions(puzzle) do
    case search_bound(puzzle) do
      nil ->
        exact_dimensions(puzzle)
        |> Enum.filter(fn {rows, columns} -> consistent?(puzzle, rows, columns) end)

      bound ->
        rows = if puzzle.rows, do: [puzzle.rows], else: 1..bound
        columns = if puzzle.columns, do: [puzzle.columns], else: 1..bound

        for row <- rows,
            column <- columns,
            consistent?(puzzle, row, column),
            do: {row, column}
    end
  end

  defp search_bound(puzzle) do
    [puzzle.pieces, puzzle.border, if(puzzle.inside && puzzle.inside > 0, do: puzzle.inside + 2)]
    |> Enum.reject(&is_nil/1)
    |> Enum.min(fn -> nil end)
  end

  defp exact_dimensions(%{rows: rows, columns: columns})
       when is_integer(rows) and is_integer(columns),
       do: [{rows, columns}]

  defp exact_dimensions(%{rows: rows, aspect_ratio: ratio})
       when is_integer(rows) and is_number(ratio) do
    columns = round(rows * ratio)
    if abs(columns / rows - ratio) < 1.0e-9, do: [{rows, columns}], else: []
  end

  defp exact_dimensions(%{columns: columns, aspect_ratio: ratio})
       when is_integer(columns) and is_number(ratio) and ratio > 0 do
    rows = round(columns / ratio)
    if abs(columns / rows - ratio) < 1.0e-9, do: [{rows, columns}], else: []
  end

  defp exact_dimensions(%{rows: rows, format: :square}) when is_integer(rows), do: [{rows, rows}]

  defp exact_dimensions(%{columns: columns, format: :square}) when is_integer(columns),
    do: [{columns, columns}]

  defp exact_dimensions(_puzzle), do: []

  defp consistent?(puzzle, rows, columns) do
    pieces = rows * columns
    border = border_pieces(rows, columns)
    ratio = columns / rows

    (is_nil(puzzle.pieces) or puzzle.pieces == pieces) and
      (is_nil(puzzle.rows) or puzzle.rows == rows) and
      (is_nil(puzzle.columns) or puzzle.columns == columns) and
      (is_nil(puzzle.border) or puzzle.border == border) and
      (is_nil(puzzle.inside) or puzzle.inside == pieces - border) and
      (is_nil(puzzle.aspect_ratio) or abs(puzzle.aspect_ratio - ratio) < 1.0e-9) and
      (is_nil(puzzle.format) or puzzle.format == format(rows, columns))
  end

  defp border_pieces(rows, columns) when rows == 1 or columns == 1, do: rows * columns
  defp border_pieces(rows, columns), do: 2 * rows + 2 * columns - 4

  defp format(rows, columns) when rows == columns, do: :square
  defp format(rows, columns) when columns > rows, do: :landscape
  defp format(_rows, _columns), do: :portrait
end
