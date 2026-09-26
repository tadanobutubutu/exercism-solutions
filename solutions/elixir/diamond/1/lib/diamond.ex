defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
    letters = Enum.to_list(?A..letter)
    rows = letters ++ (Enum.drop(Enum.reverse(letters), 1))

    rows
    |> Enum.map(fn char ->
      padding = String.duplicate(" ", letter - char)
      middle = if char == ?A, do: "", else: String.duplicate(" ", 2 * (char - ?A) - 1)
      line = if char == ?A, do: "A", else: "#{<<char::utf8>>}#{middle}#{<<char::utf8>>}"
      padding <> line <> padding
    end)
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end
end
