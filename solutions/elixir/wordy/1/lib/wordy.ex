defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
    case Regex.run(~r/^What is (.+)\?$/, String.trim(question)) do
      [_, expression] ->
        expression
        |> tokenize()
        |> parse()

      _ ->
        raise ArgumentError, "invalid math question"
    end
  end

  defp tokenize(expression) do
    expression =
      expression
      |> String.downcase()
      |> String.replace(~r/\bmultiplied\s+by\b/, "multiplied_by")
      |> String.replace(~r/\bdivided\s+by\b/, "divided_by")

    tokens = Regex.scan(~r/-?\d+|[a-z_]+/, expression) |> List.flatten()
    residue = Regex.replace(~r/-?\d+|[a-z_]+|\s+/, expression, "")

    if residue != "" do
      raise ArgumentError, "invalid math expression"
    end

    tokens
  end

  defp parse([number | rest]) do
    case Integer.parse(number) do
      {left, ""} -> parse_operations(left, rest)
      _ -> raise ArgumentError, "expected a number"
    end
  end

  defp parse(_tokens), do: raise(ArgumentError, "expected a number")

  defp parse_operations(value, []), do: value

  defp parse_operations(value, [operation, number | rest]) do
    with {right, ""} <- Integer.parse(number),
         {:ok, next} <- apply_operation(value, operation, right) do
      parse_operations(next, rest)
    else
      _ -> raise ArgumentError, "invalid math operation"
    end
  end

  defp parse_operations(_value, _tokens), do: raise(ArgumentError, "incomplete math expression")

  defp apply_operation(left, "plus", right), do: {:ok, left + right}
  defp apply_operation(left, "minus", right), do: {:ok, left - right}
  defp apply_operation(left, "multiplied_by", right), do: {:ok, left * right}
  defp apply_operation(left, "divided_by", right), do: {:ok, div(left, right)}
  defp apply_operation(_left, _operation, _right), do: :error
end
