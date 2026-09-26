defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, acc) do
    case ast do
      {kind, _metadata, [head | _rest]} when kind in [:def, :defp] ->
        head = case head do
          {:when, _guard_metadata, [call | _guards]} -> call
          call -> call
        end

        {name, _call_metadata, args} = head
        part = name |> Atom.to_string() |> String.slice(0, length(args || []))
        {ast, [part | acc]}

      _ ->
        {ast, acc}
    end
  end

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> Macro.prewalk([], fn node, acc -> decode_secret_message_part(node, acc) end)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
  end
end
