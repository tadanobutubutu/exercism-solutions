defmodule Forth do
  alias Forth.{DivisionByZero, InvalidWord, StackUnderflow, UnknownWord}

  @opaque evaluator :: any

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new, do: %{stack: [], words: %{}}

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, s) do
    s
    |> tokenize()
    |> evaluate_tokens(ev)
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(ev) do
    ev.stack
    |> Enum.reverse()
    |> Enum.join(" ")
  end

  defp tokenize(input), do: Regex.scan(~r/[^\s\p{Cc}]+/u, input) |> List.flatten()

  defp evaluate_tokens([], ev), do: ev

  defp evaluate_tokens([":", name | rest], ev) do
    case Enum.split_while(rest, &(&1 != ";")) do
      {_body, []} ->
        raise InvalidWord, word: name

      {body, [_semicolon | remaining]} ->
        if number?(name) do
          raise InvalidWord, word: name
        end

        compiled = compile_tokens(body, ev.words)
        words = Map.put(ev.words, String.downcase(name), compiled)
        evaluate_tokens(remaining, %{ev | words: words})
    end
  end

  defp evaluate_tokens([token | rest], ev) do
    ev = token |> compile_token(ev.words) |> execute(ev)
    evaluate_tokens(rest, ev)
  end

  defp compile_tokens(tokens, words), do: Enum.flat_map(tokens, &compile_token(&1, words))

  defp compile_token(token, words) do
    normalized = String.downcase(token)

    case Map.fetch(words, normalized) do
      {:ok, compiled} ->
        compiled

      :error ->
        cond do
          number?(token) -> [{:push, String.to_integer(token)}]
          normalized == "+" -> [:add]
          normalized == "-" -> [:subtract]
          normalized == "*" -> [:multiply]
          normalized == "/" -> [:divide]
          normalized == "dup" -> [:dup]
          normalized == "drop" -> [:drop]
          normalized == "swap" -> [:swap]
          normalized == "over" -> [:over]
          true -> raise UnknownWord, word: token
        end
    end
  end

  defp execute(instructions, ev), do: Enum.reduce(instructions, ev, &execute_instruction/2)

  defp execute_instruction({:push, number}, ev), do: %{ev | stack: [number | ev.stack]}

  defp execute_instruction(:dup, %{stack: [top | _] = stack} = ev),
    do: %{ev | stack: [top | stack]}

  defp execute_instruction(:dup, _ev), do: raise(StackUnderflow)

  defp execute_instruction(:drop, %{stack: [_top | rest]} = ev), do: %{ev | stack: rest}
  defp execute_instruction(:drop, _ev), do: raise(StackUnderflow)

  defp execute_instruction(:swap, %{stack: [top, next | rest]} = ev),
    do: %{ev | stack: [next, top | rest]}

  defp execute_instruction(:swap, _ev), do: raise(StackUnderflow)

  defp execute_instruction(:over, %{stack: [top, next | rest]} = ev),
    do: %{ev | stack: [next, top, next | rest]}

  defp execute_instruction(:over, _ev), do: raise(StackUnderflow)

  defp execute_instruction(operation, %{stack: [right, left | rest]} = ev)
       when operation in [:add, :subtract, :multiply, :divide] do
    result =
      case operation do
        :add -> left + right
        :subtract -> left - right
        :multiply -> left * right
        :divide when right == 0 -> raise(DivisionByZero)
        :divide -> div(left, right)
      end

    %{ev | stack: [result | rest]}
  end

  defp execute_instruction(operation, _ev)
       when operation in [:add, :subtract, :multiply, :divide],
       do: raise(StackUnderflow)

  defp number?(token), do: Regex.match?(~r/^-?[0-9]+$/, token)

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
