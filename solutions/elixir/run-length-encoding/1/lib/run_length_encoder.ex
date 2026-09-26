defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_by(& &1)
    |> Enum.map(fn run ->
      count = length(run)
      character = hd(run)
      if count == 1, do: character, else: Integer.to_string(count) <> character
    end)
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    {decoded, digits} =
      string
      |> String.graphemes()
      |> Enum.reduce({[], []}, fn character, {chunks, digits} ->
        if character in ~w(0 1 2 3 4 5 6 7 8 9) do
          {chunks, [character | digits]}
        else
          count = if digits == [], do: 1, else: digits |> Enum.reverse() |> Enum.join() |> String.to_integer()
          {[String.duplicate(character, count) | chunks], []}
        end
      end)

    if digits == [] do
      decoded |> Enum.reverse() |> Enum.join()
    else
      raise ArgumentError, "encoded string cannot end with a count"
    end
  end
end
