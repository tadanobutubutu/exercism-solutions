defmodule SgfParsing do
  defmodule Sgf do
    defstruct properties: %{}, children: []
  end

  @type sgf :: %Sgf{properties: map, children: [sgf]}

  @doc """
  Parse a string into a Smart Game Format tree
  """
  @spec parse(encoded :: String.t()) :: {:ok, sgf} | {:error, String.t()}
  def parse(encoded) do
    case parse_tree(String.to_charlist(encoded)) do
      {:ok, tree, []} -> {:ok, tree}
      {:ok, _tree, _trailing} -> {:error, "tree missing"}
      {:error, message} -> {:error, message}
    end
  end

  defp parse_tree([?( | rest]) do
    with {:ok, root, remaining} <- parse_sequence(rest, []),
         [?) | trailing] <- remaining do
      {:ok, root, trailing}
    else
      {:error, _message} = error -> error
      _ -> {:error, "tree missing"}
    end
  end

  defp parse_tree(_input), do: {:error, "tree missing"}

  defp parse_sequence([?; | rest], nodes) do
    with {:ok, properties, remaining} <- parse_properties(rest, %{}) do
      node = %Sgf{properties: properties}
      parse_sequence(remaining, [node | nodes])
    end
  end

  defp parse_sequence(_remaining, []), do: {:error, "tree with no nodes"}

  defp parse_sequence(remaining, reversed_nodes) do
    parse_variations(remaining, Enum.reverse(reversed_nodes), [])
  end

  defp parse_variations([?( | _rest] = input, nodes, branches) do
    with {:ok, branch, remaining} <- parse_tree(input) do
      parse_variations(remaining, nodes, [branch | branches])
    end
  end

  defp parse_variations([?) | _rest] = remaining, nodes, branches) do
    root = nodes |> build_chain() |> attach_branches(Enum.reverse(branches))
    {:ok, root, remaining}
  end

  defp parse_variations(_remaining, _nodes, _branches), do: {:error, "tree missing"}

  defp build_chain([node]), do: node

  defp build_chain([node | rest]) do
    %{node | children: [build_chain(rest)]}
  end

  defp attach_branches(node, branches) do
    case node.children do
      [] -> %{node | children: branches}
      [child] -> %{node | children: [attach_branches(child, branches)]}
    end
  end

  defp parse_properties([char | _rest] = input, properties)
       when char in ?A..?Z or char in ?a..?z do
    {identifier, remaining} = take_identifier(input, [])

    if Enum.any?(identifier, &(&1 in ?a..?z)) do
      {:error, "property must be in uppercase"}
    else
      key = List.to_string(identifier)

      with {:ok, values, remaining} <- parse_values(remaining, []) do
        properties = Map.update(properties, key, values, &(&1 ++ values))
        parse_properties(remaining, properties)
      end
    end
  end

  defp parse_properties([char | _rest] = remaining, properties)
       when char in [?;, ?(, ?)] do
    {:ok, properties, remaining}
  end

  defp parse_properties([], properties), do: {:ok, properties, []}
  defp parse_properties(_remaining, _properties), do: {:error, "properties without delimiter"}

  defp take_identifier([char | rest], acc) when char in ?A..?Z or char in ?a..?z,
    do: take_identifier(rest, [char | acc])

  defp take_identifier(rest, acc), do: {Enum.reverse(acc), rest}

  defp parse_values([?[ | rest], values) do
    with {:ok, value, remaining} <- parse_value(rest, []) do
      parse_values(remaining, [value | values])
    end
  end

  defp parse_values(_remaining, []), do: {:error, "properties without delimiter"}
  defp parse_values(remaining, values), do: {:ok, Enum.reverse(values), remaining}

  defp parse_value([?\\, ?\n | rest], acc), do: parse_value(rest, acc)

  defp parse_value([?\\, char | rest], acc) do
    replacement = if whitespace?(char), do: ?\s, else: char
    parse_value(rest, [replacement | acc])
  end

  defp parse_value([?\\], acc), do: parse_value([], [?\\ | acc])
  defp parse_value([?] | rest], acc), do: {:ok, acc |> Enum.reverse() |> List.to_string(), rest}

  defp parse_value([char | rest], acc) do
    replacement = if char == ?\n, do: char, else: if(whitespace?(char), do: ?\s, else: char)
    parse_value(rest, [replacement | acc])
  end

  defp parse_value([], _acc), do: {:error, "unterminated property value"}

  defp whitespace?(char) do
    char in [9, 10, 11, 12, 13, 32] or char in 0x2000..0x200A or
      char in [0x00A0, 0x2028, 0x2029, 0x202F, 0x205F, 0x3000]
  end
end
