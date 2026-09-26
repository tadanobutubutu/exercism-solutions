defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    Regex.scan(~r/[\p{L}\p{N}]+(?:'[\p{L}\p{N}]+)*/u, sentence)
    |> List.flatten()
    |> Enum.map(&String.downcase/1)
    |> Enum.frequencies()
  end
end
