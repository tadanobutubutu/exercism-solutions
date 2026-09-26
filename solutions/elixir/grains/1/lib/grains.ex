defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(number) do
    if number in 1..64 do
      {:ok, power_of_two(number - 1)}
    else
      {:error, "The requested square must be between 1 and 64 (inclusive)"}
    end
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
    {:ok, Enum.reduce(1..64, 0, fn square, total -> total + power_of_two(square - 1) end)}
  end

  defp power_of_two(0), do: 1
  defp power_of_two(exponent), do: 2 * power_of_two(exponent - 1)
end
