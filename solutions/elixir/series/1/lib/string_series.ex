defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    length = String.length(s)

    if size < 1 or size > length do
      []
    else
      for start <- 0..(length - size), do: String.slice(s, start, size)
    end
  end
end
