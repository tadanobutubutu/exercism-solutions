defmodule Bowling.Game do
  defstruct rolls: []
end

defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start, do: %Bowling.Game{}

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """

  @spec roll(any, integer) :: {:ok, any} | {:error, String.t()}
  def roll(game, roll) do
    cond do
      roll < 0 ->
        {:error, "Negative roll is invalid"}

      roll > 10 ->
        {:error, "Pin count exceeds pins on the lane"}

      game_over?(game.rolls) ->
        {:error, "Cannot roll after game is over"}

      roll > max_roll(game.rolls) ->
        {:error, "Pin count exceeds pins on the lane"}

      true ->
        {:ok, %{game | rolls: game.rolls ++ [roll]}}
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """

  @spec score(any) :: {:ok, integer} | {:error, String.t()}
  def score(game) do
    if game_over?(game.rolls) do
      {:ok, score_frames(game.rolls, 0)}
    else
      {:error, "Score cannot be taken until the end of the game"}
    end
  end

  defp max_roll(rolls) do
    case locate_current_frame(rolls, 0) do
      {:regular, []} -> 10
      {:regular, [first]} -> 10 - first
      {:tenth, []} -> 10
      {:tenth, [first]} -> if first == 10, do: 10, else: 10 - first
      {:tenth, [first, second]} when first == 10 -> if second == 10, do: 10, else: 10 - second
      {:tenth, [first, second]} when first + second == 10 -> 10
      {:tenth, _complete} -> 0
    end
  end

  defp game_over?(rolls) do
    case locate_current_frame(rolls, 0) do
      {:regular, _incomplete_frame} -> false
      {:tenth, []} -> false
      {:tenth, [_first]} -> false
      {:tenth, [10, _second]} -> false
      {:tenth, [first, second]} when first + second == 10 -> false
      {:tenth, [_first, _second]} -> true
      {:tenth, [_first, _second, _bonus]} -> true
    end
  end

  defp locate_current_frame(rolls, 9), do: {:tenth, rolls}
  defp locate_current_frame([], _completed_frames), do: {:regular, []}

  defp locate_current_frame([10 | rest], completed_frames),
    do: locate_current_frame(rest, completed_frames + 1)

  defp locate_current_frame([first], _completed_frames), do: {:regular, [first]}

  defp locate_current_frame([_first, _second | rest], completed_frames),
    do: locate_current_frame(rest, completed_frames + 1)

  defp score_frames(_rolls, 10), do: 0

  defp score_frames([10 | rest], frame) do
    10 + Enum.at(rest, 0) + Enum.at(rest, 1) + score_frames(rest, frame + 1)
  end

  defp score_frames([first, second | rest], frame) when first + second == 10 do
    10 + Enum.at(rest, 0) + score_frames(rest, frame + 1)
  end

  defp score_frames([first, second | rest], frame) do
    first + second + score_frames(rest, frame + 1)
  end

  defp score_frames(tenth_frame, 9), do: Enum.sum(tenth_frame)
end
