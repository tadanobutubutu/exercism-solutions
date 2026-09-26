defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    number = String.replace(raw, ~r/[\s().-]/u, "")

    number =
      if String.starts_with?(number, "+1"),
        do: binary_part(number, 2, byte_size(number) - 2),
        else: number

    cond do
      not Regex.match?(~r/^\d*$/, number) ->
        {:error, "must contain digits only"}

      String.length(number) < 10 ->
        {:error, "must not be fewer than 10 digits"}

      String.length(number) > 11 ->
        {:error, "must not be greater than 11 digits"}

      String.length(number) == 11 and not String.starts_with?(number, "1") ->
        {:error, "11 digits must start with 1"}

      true ->
        ten_digits = if String.length(number) == 11, do: binary_part(number, 1, 10), else: number
        validate_number(ten_digits)
    end
  end

  defp validate_number(
         <<area_code::binary-size(3), exchange_code::binary-size(3), subscriber::binary-size(4)>>
       ) do
    area_first = String.first(area_code)
    exchange_first = String.first(exchange_code)

    cond do
      area_first == "0" -> {:error, "area code cannot start with zero"}
      area_first == "1" -> {:error, "area code cannot start with one"}
      exchange_first == "0" -> {:error, "exchange code cannot start with zero"}
      exchange_first == "1" -> {:error, "exchange code cannot start with one"}
      true -> {:ok, area_code <> exchange_code <> subscriber}
    end
  end
end
