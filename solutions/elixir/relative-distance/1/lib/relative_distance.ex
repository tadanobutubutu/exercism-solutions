defmodule RelativeDistance do
  @doc """
  Find the degree of separation of two members given a given family tree.
  """
  @spec degree_of_separation(
          family_tree :: %{String.t() => [String.t()]},
          person_a :: String.t(),
          person_b :: String.t()
        ) :: nil | pos_integer()
  def degree_of_separation(family_tree, person_a, person_b) do
    if person_a == person_b do
      0
    else
      graph =
        Enum.reduce(family_tree, %{}, fn {parent, children}, graph ->
          graph =
            Enum.reduce(children, Map.put_new(graph, parent, []), fn child, graph ->
              graph
              |> Map.update(parent, [child], &[child | &1])
              |> Map.update(child, [parent], &[parent | &1])
            end)

          Enum.reduce(children, graph, fn sibling, graph ->
            Enum.reduce(children, graph, fn other, graph ->
              if sibling == other do
                graph
              else
                graph
                |> Map.update(sibling, [other], &[other | &1])
                |> Map.update(other, [sibling], &[sibling | &1])
              end
            end)
          end)
        end)

      shortest_distance(
        :queue.in({person_a, 0}, :queue.new()),
        graph,
        MapSet.new([person_a]),
        person_b
      )
    end
  end

  defp shortest_distance(queue, graph, visited, target) do
    case :queue.out(queue) do
      {:empty, _queue} ->
        nil

      {{:value, {person, distance}}, rest} ->
        if person == target do
          distance
        else
          {queue, visited} =
            Enum.reduce(Map.get(graph, person, []), {rest, visited}, fn neighbor,
                                                                        {queue, visited} ->
              if MapSet.member?(visited, neighbor) do
                {queue, visited}
              else
                {:queue.in({neighbor, distance + 1}, queue), MapSet.put(visited, neighbor)}
              end
            end)

          shortest_distance(queue, graph, visited, target)
        end
    end
  end
end
