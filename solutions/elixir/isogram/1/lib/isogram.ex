defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    letters =
      sentence
      |> String.downcase()
      |> String.graphemes()
      |> Enum.reject(&(&1 in [" ", "-"]))

    length(letters) == MapSet.size(MapSet.new(letters))
  end
end
