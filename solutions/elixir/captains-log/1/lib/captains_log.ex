defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    "NCC-#{:rand.uniform(9000) + 999}"
  end

  def random_stardate() do
    41_000.0 + 1_000 * :rand.uniform()
  end

  def format_stardate(stardate) when is_float(stardate) do
    stardate
    |> then(&:io_lib.format("~.1f", [&1]))
    |> List.to_string()
  end

  def format_stardate(_stardate) do
    raise ArgumentError, "stardate must be a float"
  end
end
