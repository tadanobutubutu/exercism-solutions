defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Task.async_stream(&count_letters/1,
      max_concurrency: max(workers, 1),
      ordered: false
    )
    |> Enum.reduce(%{}, fn {:ok, frequencies}, total ->
      Map.merge(total, frequencies, fn _char, a, b -> a + b end)
    end)
  end

  defp count_letters(text) do
    text
    |> String.graphemes()
    |> Enum.reduce(%{}, fn char, frequencies ->
      if Regex.match?(~r/^\p{L}$/u, char) do
        char = String.downcase(char)
        Map.update(frequencies, char, 1, &(&1 + 1))
      else
        frequencies
      end
    end)
  end
end
