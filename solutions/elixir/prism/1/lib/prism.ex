defmodule Prism do
  @doc """
  Finds the sequence of prisms that the laser will hit.
  """

  @type start :: %{angle: number(), x: number(), y: number()}
  @type prism :: %{id: integer(), angle: number(), x: number(), y: number()}

  @spec find_sequence(prisms :: [prism()], start :: start()) :: [integer()]
  def find_sequence(prisms, start) do
    trace(prisms, start.x * 1.0, start.y * 1.0, start.angle * 1.0, [], MapSet.new())
  end

  defp trace(prisms, x, y, angle, hits, seen) do
    direction = radians(angle)
    dx = :math.cos(direction)
    dy = :math.sin(direction)

    next_prism =
      prisms
      |> Enum.map(fn prism -> {distance_along_ray(prism, x, y, dx, dy), prism} end)
      |> Enum.filter(fn {distance, _prism} -> is_number(distance) end)
      |> Enum.min_by(&elem(&1, 0), fn -> nil end)

    case next_prism do
      nil ->
        Enum.reverse(hits)

      {_distance, prism} ->
        new_angle = angle + prism.angle
        state = {prism.id, round_angle(new_angle)}

        if MapSet.member?(seen, state) do
          Enum.reverse([prism.id | hits])
        else
          trace(
            prisms,
            prism.x,
            prism.y,
            new_angle,
            [prism.id | hits],
            MapSet.put(seen, state)
          )
        end
    end
  end

  defp distance_along_ray(prism, x, y, dx, dy) do
    offset_x = prism.x - x
    offset_y = prism.y - y
    distance = offset_x * dx + offset_y * dy
    perpendicular_distance = abs(offset_x * dy - offset_y * dx)

    if distance > 1.0e-8 and perpendicular_distance <= 0.1 do
      distance
    end
  end

  defp radians(degrees), do: degrees * :math.pi() / 180
  defp round_angle(angle), do: Float.round(:math.fmod(angle, 360.0), 8)
end
