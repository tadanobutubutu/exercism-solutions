defmodule Username do
  def sanitize(username) do
    username
    |> Enum.flat_map(fn
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      ?_ -> [?_]
      character when character >= ?a and character <= ?z -> [character]
      _ -> []
    end)
  end
end
