defmodule OcrNumbers do
  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, String.t()}
  def convert(input) do
    cond do
      rem(length(input), 4) != 0 ->
        {:error, "invalid line count"}

      input == [] ->
        {:ok, ""}

      true ->
        width = input |> Enum.map(&String.length/1) |> Enum.max()

        if rem(width, 3) != 0 or Enum.any?(input, &(String.length(&1) != width)) do
          {:error, "invalid column count"}
        else
          input
          |> Enum.chunk_every(4)
          |> Enum.map(&convert_group(&1, width))
          |> Enum.join(",")
          |> then(&{:ok, &1})
        end
    end
  end

  defp convert_group(rows, width) do
    for column <- 0..(div(width, 3) - 1) do
      pattern =
        rows
        |> Enum.map(&String.slice(&1, column * 3, 3))
        |> Enum.join("\n")

      Map.get(digit_patterns(), pattern, "?")
    end
    |> Enum.join()
  end

  defp digit_patterns do
    %{
      " _ \n| |\n|_|\n   " => "0",
      "   \n  |\n  |\n   " => "1",
      " _ \n _|\n|_ \n   " => "2",
      " _ \n _|\n _|\n   " => "3",
      "   \n|_|\n  |\n   " => "4",
      " _ \n|_ \n _|\n   " => "5",
      " _ \n|_ \n|_|\n   " => "6",
      " _ \n  |\n  |\n   " => "7",
      " _ \n|_|\n|_|\n   " => "8",
      " _ \n|_|\n _|\n   " => "9"
    }
  end
end
