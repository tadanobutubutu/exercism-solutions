defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    trimmed = String.trim(input)
    question? = String.ends_with?(trimmed, "?")
    letters = Regex.scan(~r/\p{L}/u, trimmed) |> List.flatten()
    shouting? = letters != [] and Enum.all?(letters, &(String.upcase(&1) == &1))

    cond do
      trimmed == "" -> "Fine. Be that way!"
      shouting? and question? -> "Calm down, I know what I'm doing!"
      shouting? -> "Whoa, chill out!"
      question? -> "Sure."
      true -> "Whatever."
    end
  end
end
