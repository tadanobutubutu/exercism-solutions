defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    compact = String.replace(number, " ", "")

    if byte_size(compact) <= 1 or not Regex.match?(~r/\A[0-9]+\z/, compact) do
      false
    else
      compact
      |> String.graphemes()
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.reduce(0, fn {digit, index}, sum ->
        value = String.to_integer(digit)
        adjusted = if rem(index, 2) == 1, do: if(value * 2 > 9, do: value * 2 - 9, else: value * 2), else: value
        sum + adjusted
      end)
      |> rem(10)
      |> Kernel.==(0)
    end
  end
end
