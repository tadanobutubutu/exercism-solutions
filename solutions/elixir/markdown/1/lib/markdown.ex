defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

      iex> Markdown.parse("This is a paragraph")
      "<p>This is a paragraph</p>"

      iex> Markdown.parse("# Header!\\n* __Bold Item__\\n* _Italic Item_")
      "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    {blocks, list_items} =
      markdown
      |> String.split("\n")
      |> Enum.reduce({[], []}, &collect_block/2)

    (blocks ++ render_list(list_items))
    |> Enum.join()
  end

  defp collect_block(line, {blocks, list_items}) do
    case classify(line) do
      {:list, item} ->
        {blocks, [item | list_items]}

      :other ->
        {blocks ++ render_list(list_items) ++ [render_line(line)], []}
    end
  end

  defp classify("* " <> item), do: {:list, item}
  defp classify(_line), do: :other

  defp render_list([]), do: []

  defp render_list(items),
    do: ["<ul>" <> Enum.map_join(Enum.reverse(items), "", &"<li>#{inline(&1)}</li>") <> "</ul>"]

  defp render_line(line) do
    case Regex.run(~r/^(\#{1,6}) (.*)$/, line) do
      [_, hashes, text] ->
        level = String.length(hashes)
        "<h#{level}>#{text}</h#{level}>"

      _ ->
        "<p>#{inline(line)}</p>"
    end
  end

  defp inline(text) do
    text =
      Regex.replace(~r/__([^_]+)__/, text, fn _, content -> "<strong>#{content}</strong>" end)

    Regex.replace(~r/(?<!_)_([^_]+)_(?!_)/, text, fn _, content -> "<em>#{content}</em>" end)
  end
end
