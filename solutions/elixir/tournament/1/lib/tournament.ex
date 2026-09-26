defmodule Tournament do
  @header "Team                           | MP |  W |  D |  L |  P"

  @spec tally([String.t()]) :: String.t()
  def tally(results) do
    results
    |> Enum.reduce(%{}, &record_result/2)
    |> Enum.sort_by(fn {team, stats} -> {-stats.points, team} end)
    |> Enum.map(fn {team, stats} -> format_row(team, stats) end)
    |> then(fn rows -> Enum.join([@header | rows], "\n") end)
  end

  defp record_result(line, table) do
    case String.split(line, ";") do
      [team_a, team_b, outcome] when outcome in ["win", "draw", "loss"] ->
        {delta_a, delta_b} = deltas(outcome)

        table
        |> update_team(team_a, delta_a)
        |> update_team(team_b, delta_b)

      _ ->
        table
    end
  end

  defp deltas("win"), do: {%{won: 1, drawn: 0, lost: 0, points: 3}, %{won: 0, drawn: 0, lost: 1, points: 0}}
  defp deltas("loss"), do: {%{won: 0, drawn: 0, lost: 1, points: 0}, %{won: 1, drawn: 0, lost: 0, points: 3}}
  defp deltas("draw"), do: {%{won: 0, drawn: 1, lost: 0, points: 1}, %{won: 0, drawn: 1, lost: 0, points: 1}}

  defp update_team(table, team, delta) do
    stats = Map.get(table, team, %{played: 0, won: 0, drawn: 0, lost: 0, points: 0})

    updated = %{
      played: stats.played + 1,
      won: stats.won + delta.won,
      drawn: stats.drawn + delta.drawn,
      lost: stats.lost + delta.lost,
      points: stats.points + delta.points
    }

    Map.put(table, team, updated)
  end

  defp format_row(team, stats) do
    "#{String.pad_trailing(team, 31)}| #{pad(stats.played)} | #{pad(stats.won)} | #{pad(stats.drawn)} | #{pad(stats.lost)} | #{pad(stats.points)}"
  end

  defp pad(number), do: number |> Integer.to_string() |> String.pad_leading(2)
end
