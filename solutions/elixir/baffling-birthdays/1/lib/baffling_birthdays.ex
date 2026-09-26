defmodule BafflingBirthdays do
  @moduledoc """
  Estimate the probability of shared birthdays in a group of people.
  """

  @spec shared_birthday?(birthdates :: [Date.t()]) :: boolean()
  def shared_birthday?(birthdates) do
    birthdays = Enum.map(birthdates, &{&1.month, &1.day})
    length(Enum.uniq(birthdays)) != length(birthdays)
  end

  @spec random_birthdates(group_size :: integer()) :: [Date.t()]
  def random_birthdates(group_size) do
    if group_size <= 0 do
      []
    else
      Enum.map(1..group_size, fn _ ->
        days_after_new_year = :rand.uniform(365) - 1
        Date.add(~D[2001-01-01], days_after_new_year)
      end)
    end
  end

  @spec estimated_probability_of_shared_birthday(group_size :: integer()) :: float()
  def estimated_probability_of_shared_birthday(group_size) do
    if group_size <= 1 do
      0.0
    else
      probability_of_no_shared_birthday =
        Enum.reduce(0..(min(group_size, 366) - 1), 1.0, fn previous_birthdays, probability ->
          probability * (365 - previous_birthdays) / 365
        end)

      (1.0 - probability_of_no_shared_birthday) * 100.0
    end
  end
end
