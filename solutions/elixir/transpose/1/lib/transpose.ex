defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    rows = String.split(input, "\n", trim: true)
    max_width = rows |> Enum.map(&String.length/1) |> Enum.max(fn -> 0 end)

    for column <- 0..(max_width - 1)//1, max_width > 0 do
      rows
      |> Enum.map(&String.at(&1, column))
      |> Enum.with_index()
      |> Enum.reverse()
      |> Enum.drop_while(fn {character, _index} -> is_nil(character) end)
      |> Enum.reverse()
      |> Enum.map(fn
        {nil, _index} -> " "
        {character, _index} -> character
      end)
      |> Enum.join()
    end
    |> Enum.join("\n")
  end
end
