defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes()
    |> Enum.reduce_while([], fn character, stack ->
      cond do
        character in ["(", "[", "{"] ->
          {:cont, [character | stack]}

        character in [")", "]", "}"] ->
          case stack do
            [open | rest] when {open, character} in [{"(", ")"}, {"[", "]"}, {"{", "}"}] ->
              {:cont, rest}

            _ ->
              {:halt, :invalid}
          end

        true ->
          {:cont, stack}
      end
    end)
    |> case do
      [] -> true
      _ -> false
    end
  end
end
