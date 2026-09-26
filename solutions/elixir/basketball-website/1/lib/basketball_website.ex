defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path
    |> String.split(".")
    |> Enum.reduce_while(data, fn key, current ->
      if is_map(current) do
        case current[key] do
          nil -> {:halt, nil}
          value -> {:cont, value}
        end
      else
        {:halt, nil}
      end
    end)
  end

  def get_in_path(data, path) do
    accessors = path |> String.split(".") |> Enum.map(&Access.key/1)
    get_in(data, accessors)
  end
end
