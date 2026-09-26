defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    digits = String.to_charlist(number_string)

    unless Enum.all?(digits, &(&1 in ?0..?9)) do
      raise ArgumentError, "series must contain only digits"
    end

    if size < 0 or size > length(digits) or (size > 0 and digits == []) do
      raise ArgumentError, "span must be between zero and the input length"
    end

    if size == 0 do
      1
    else
      digits
      |> Enum.chunk_every(size, 1, :discard)
      |> Enum.map(fn series -> Enum.reduce(series, 1, &((&1 - ?0) * &2)) end)
      |> Enum.max()
    end
  end
end
