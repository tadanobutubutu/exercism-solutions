defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    compact = String.replace(isbn, "-", "")

    if Regex.match?(~r/^[0-9]{9}[0-9X]$/, compact) do
      digits =
        compact
        |> String.graphemes()
        |> Enum.map(fn
          "X" -> 10
          digit -> String.to_integer(digit)
        end)

      digits
      |> Enum.with_index(1)
      |> Enum.reduce(0, fn {digit, weight}, sum -> sum + digit * (11 - weight) end)
      |> rem(11)
      |> Kernel.==(0)
    else
      false
    end
  end
end
