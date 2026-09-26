defmodule Dot do
  defmacro graph(do: block) do
    statements =
      case block do
        {:__block__, _meta, expressions} -> expressions
        nil -> []
        expression -> [expression]
      end

    Enum.reduce(statements, quote(do: Graph.new()), fn statement, graph ->
      expand_statement(statement, graph)
    end)
  end

  defp expand_statement({:graph, _meta, [attrs]}, graph) do
    validate_attrs!(attrs, "graph")
    quote do: Graph.put_attrs(unquote(graph), unquote(attrs))
  end

  defp expand_statement({:--, _meta, [left, right]}, graph) do
    {from, from_attrs} = endpoint!(left)
    {to, edge_attrs} = endpoint!(right)
    validate_attrs!(from_attrs, "node")
    validate_attrs!(edge_attrs, "edge")

    quote do
      graph = Graph.add_node(unquote(graph), unquote(from), unquote(from_attrs))
      Graph.add_edge(graph, unquote(from), unquote(to), unquote(edge_attrs))
    end
  end

  defp expand_statement({name, _meta, nil}, graph) when is_atom(name) do
    quote do: Graph.add_node(unquote(graph), unquote(name))
  end

  defp expand_statement({name, _meta, [attrs]}, graph) when is_atom(name) do
    validate_attrs!(attrs, "node")
    quote do: Graph.add_node(unquote(graph), unquote(name), unquote(attrs))
  end

  defp expand_statement(_statement, _graph) do
    raise ArgumentError, "invalid statement in graph block"
  end

  defp endpoint!({name, _meta, nil}) when is_atom(name), do: {name, []}

  defp endpoint!({name, _meta, [attrs]}) when is_atom(name) do
    validate_attrs!(attrs, "edge")
    {name, attrs}
  end

  defp endpoint!(_endpoint), do: raise(ArgumentError, "invalid node name in edge")

  defp validate_attrs!(attrs, kind) do
    unless is_list(attrs) and Keyword.keyword?(attrs) do
      raise ArgumentError, "#{kind} attributes must be a keyword list"
    end
  end
end
