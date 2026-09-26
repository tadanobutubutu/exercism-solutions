defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    search(radicand, 1, radicand)
  end

  defp search(radicand, low, high) do
    middle = div(low + high, 2)
    square = middle * middle

    cond do
      square == radicand -> middle
      square > radicand -> search(radicand, low, middle - 1)
      true -> search(radicand, middle + 1, high)
    end
  end
end
