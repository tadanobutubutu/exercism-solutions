defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite(strings) do
    case strings do
      [] -> ""
      [first | _] ->
        pairs = strings |> Enum.chunk_every(2, 1, :discard)

        lines =
          Enum.map(pairs, fn [current, next] ->
            "For want of a #{current} the #{next} was lost."
          end) ++ ["And all for the want of a #{first}."]

        Enum.join(lines, "\n") <> "\n"
    end
  end
end
