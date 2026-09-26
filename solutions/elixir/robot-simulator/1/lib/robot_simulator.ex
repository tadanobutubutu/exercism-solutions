defmodule RobotSimulator do
  @type robot() :: any()
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ nil, position \\ nil) do
    directions = [:north, :east, :south, :west]

    cond do
      direction == nil and position == nil -> %{direction: :north, position: {0, 0}}
      direction not in directions -> {:error, "invalid direction"}
      not (is_tuple(position) and tuple_size(position) == 2 and is_integer(elem(position, 0)) and is_integer(elem(position, 1)))->
        {:error, "invalid position"}
      true -> %{direction: direction, position: position}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instructions) do
    Enum.reduce_while(String.to_charlist(instructions), robot, fn
      ?R, current -> {:cont, rotate(current, 1)}
      ?L, current -> {:cont, rotate(current, -1)}
      ?A, current -> {:cont, advance(current)}
      _invalid, _current -> {:halt, {:error, "invalid instruction"}}
    end)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot) do
    robot.position
  end

  defp rotate(robot, amount) do
    directions = [:north, :east, :south, :west]
    index = Enum.find_index(directions, &(&1 == robot.direction))
    %{robot | direction: Enum.at(directions, Integer.mod(index + amount, 4))}
  end

  defp advance(%{direction: :north, position: {x, y}} = robot), do: %{robot | position: {x, y + 1}}
  defp advance(%{direction: :east, position: {x, y}} = robot), do: %{robot | position: {x + 1, y}}
  defp advance(%{direction: :south, position: {x, y}} = robot), do: %{robot | position: {x, y - 1}}
  defp advance(%{direction: :west, position: {x, y}} = robot), do: %{robot | position: {x - 1, y}}
end
