defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.flat_map(fn
      char when char in ?a..?z -> [?z - (char - ?a)]
      char when char in ?0..?9 -> [char]
      _ -> []
    end)
    |> Enum.chunk_every(5)
    |> Enum.map(&List.to_string/1)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.flat_map(fn
      char when char in ?a..?z -> [?z - (char - ?a)]
      char when char in ?0..?9 -> [char]
      _ -> []
    end)
    |> List.to_string()
  end
end
