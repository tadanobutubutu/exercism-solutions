defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) do
    if number <= 0 do
      {:error, "Classification is only possible for natural numbers."}
    else
      aliquot_sum =
        if number == 1 do
          0
        else
          limit = :math.sqrt(number) |> floor()

          Enum.reduce(1..limit, 0, fn divisor, sum ->
            if rem(number, divisor) == 0 do
              paired_divisor = div(number, divisor)
              sum + divisor + if(paired_divisor != divisor and divisor != number, do: paired_divisor, else: 0)
            else
              sum
            end
          end) - number
        end

      classification =
        cond do
          aliquot_sum == number -> :perfect
          aliquot_sum > number -> :abundant
          true -> :deficient
        end

      {:ok, classification}
    end
  end
end
