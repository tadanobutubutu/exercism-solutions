defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    length = length(digits)
    Enum.reduce(digits, 0, fn digit, sum -> sum + integer_power(digit, length) end) == number
  end

  defp integer_power(_number, 0), do: 1
  defp integer_power(number, exponent), do: number * integer_power(number, exponent - 1)
end
