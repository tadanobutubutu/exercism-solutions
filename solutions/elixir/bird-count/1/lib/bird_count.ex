defmodule BirdCount do
  def today(list) do
    List.first(list)
  end

  def increment_day_count(list) do
    case list do
      [] -> [1]
      [today | previous_days] -> [today + 1 | previous_days]
    end
  end

  def has_day_without_birds?(list) do
    Enum.any?(list, &(&1 == 0))
  end

  def total(list) do
    Enum.sum(list)
  end

  def busy_days(list) do
    Enum.count(list, &(&1 >= 5))
  end
end
