defmodule Alphametics do
  @type puzzle :: binary
  @type solution :: %{required(?A..?Z) => 0..9}

  @doc """
  Takes an alphametics puzzle and returns a solution where every letter
  replaced by its number will make a valid equation. Returns `nil` when
  there is no valid solution to the given puzzle.

  ## Examples

    iex> Alphametics.solve("I + BB == ILL")
    %{?I => 1, ?B => 9, ?L => 0}

    iex> Alphametics.solve("A == B")
    nil
  """
  @spec solve(puzzle) :: solution | nil
  def solve(puzzle) do
    case String.split(puzzle, " == ") do
      [addends_text, result_text] ->
        addends = addends_text |> String.split(" + ") |> Enum.map(&String.to_charlist/1)
        result = String.to_charlist(result_text)
        words = addends ++ [result]
        letters = words |> List.flatten() |> Enum.uniq()

        if length(letters) > 10 do
          nil
        else
          leading =
            words
            |> Enum.filter(&(length(&1) > 1))
            |> Enum.map(&List.first/1)
            |> MapSet.new()

          columns = build_columns(addends, result)
          solve_column(columns, 0, 0, %{}, MapSet.new(), leading)
        end

      _ ->
        nil
    end
  end

  defp build_columns(addends, result) do
    width = max(Enum.max(Enum.map(addends ++ [result], &length/1)), 1)

    for column <- 0..(width - 1) do
      coefficients =
        addends
        |> Enum.reduce(%{}, fn word, counts ->
          case Enum.at(Enum.reverse(word), column) do
            nil -> counts
            letter -> Map.update(counts, letter, 1, &(&1 + 1))
          end
        end)

      result_letter = result |> Enum.reverse() |> Enum.at(column)

      ordered_letters =
        coefficients
        |> Map.keys()
        |> Enum.sort_by(fn letter -> {-Map.fetch!(coefficients, letter), letter} end)

      {ordered_letters, coefficients, result_letter}
    end
  end

  defp solve_column(columns, column, carry, mapping, _used, _leading)
       when column == length(columns) do
    if carry == 0, do: mapping, else: nil
  end

  defp solve_column(columns, column, carry, mapping, used, leading) do
    {letters, coefficients, result_letter} = Enum.at(columns, column)

    assign_column_letters(
      letters,
      coefficients,
      result_letter,
      columns,
      column,
      carry,
      mapping,
      used,
      leading
    )
  end

  defp assign_column_letters(
         [],
         coefficients,
         result_letter,
         columns,
         column,
         carry,
         mapping,
         used,
         leading
       ) do
    sum =
      carry +
        Enum.reduce(coefficients, 0, fn {letter, count}, total ->
          total + count * mapping[letter]
        end)

    digit = rem(sum, 10)
    next_carry = div(sum, 10)

    case assign_result_digit(result_letter, digit, mapping, used, leading) do
      {:ok, next_mapping, next_used} ->
        solve_column(columns, column + 1, next_carry, next_mapping, next_used, leading)

      :invalid ->
        nil
    end
  end

  defp assign_column_letters(
         [letter | rest],
         coefficients,
         result_letter,
         columns,
         column,
         carry,
         mapping,
         used,
         leading
       ) do
    if Map.has_key?(mapping, letter) do
      assign_column_letters(
        rest,
        coefficients,
        result_letter,
        columns,
        column,
        carry,
        mapping,
        used,
        leading
      )
    else
      0..9
      |> Enum.reduce_while(nil, fn digit, _answer ->
        if MapSet.member?(used, digit) or (digit == 0 and MapSet.member?(leading, letter)) do
          {:cont, nil}
        else
          answer =
            assign_column_letters(
              rest,
              coefficients,
              result_letter,
              columns,
              column,
              carry,
              Map.put(mapping, letter, digit),
              MapSet.put(used, digit),
              leading
            )

          if answer, do: {:halt, answer}, else: {:cont, nil}
        end
      end)
    end
  end

  defp assign_result_digit(nil, 0, mapping, used, _leading), do: {:ok, mapping, used}
  defp assign_result_digit(nil, _digit, _mapping, _used, _leading), do: :invalid

  defp assign_result_digit(letter, digit, mapping, used, leading) do
    case Map.fetch(mapping, letter) do
      {:ok, ^digit} ->
        {:ok, mapping, used}

      {:ok, _other_digit} ->
        :invalid

      :error ->
        if MapSet.member?(used, digit) or (digit == 0 and MapSet.member?(leading, letter)) do
          :invalid
        else
          {:ok, Map.put(mapping, letter, digit), MapSet.put(used, digit)}
        end
    end
  end
end
