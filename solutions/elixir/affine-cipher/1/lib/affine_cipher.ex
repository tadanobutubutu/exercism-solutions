defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
    if Integer.gcd(a, 26) != 1 do
      {:error, "a and m must be coprime."}
    else
      message
      |> normalize()
      |> Enum.map(&encode_character(&1, a, b))
      |> Enum.chunk_every(5)
      |> Enum.map_join(" ", &List.to_string/1)
      |> then(&{:ok, &1})
    end
  end

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), encrypted :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, encrypted) do
    if Integer.gcd(a, 26) != 1 do
      {:error, "a and m must be coprime."}
    else
      inverse = Enum.find(1..25, fn candidate -> Integer.mod(a * candidate, 26) == 1 end)

      encrypted
      |> normalize()
      |> Enum.map(&decode_character(&1, inverse, b))
      |> List.to_string()
      |> then(&{:ok, &1})
    end
  end

  defp normalize(text), do: text |> String.downcase() |> String.replace(~r/[^a-z0-9]/, "") |> String.to_charlist()

  defp encode_character(char, a, b) when char in ?a..?z do
    ?a + Integer.mod(a * (char - ?a) + b, 26)
  end

  defp encode_character(char, _a, _b), do: char

  defp decode_character(char, a_inverse, b) when char in ?a..?z do
    ?a + Integer.mod(a_inverse * (char - ?a - b), 26)
  end

  defp decode_character(char, _a_inverse, _b), do: char
end
