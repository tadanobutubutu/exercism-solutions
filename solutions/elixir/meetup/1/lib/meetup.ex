defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, schedule) do
    weekday_number = %{
      monday: 1,
      tuesday: 2,
      wednesday: 3,
      thursday: 4,
      friday: 5,
      saturday: 6,
      sunday: 7
    }[weekday]

    days = Date.days_in_month(Date.new!(year, month, 1))

    matching_days =
      1..days
      |> Enum.filter(fn day ->
        Date.day_of_week(Date.new!(year, month, day)) == weekday_number
      end)

    selected_day =
      case schedule do
        :teenth -> Enum.find(13..19, fn day -> Date.day_of_week(Date.new!(year, month, day)) == weekday_number end)
        :first -> Enum.at(matching_days, 0)
        :second -> Enum.at(matching_days, 1)
        :third -> Enum.at(matching_days, 2)
        :fourth -> Enum.at(matching_days, 3)
        :last -> List.last(matching_days)
      end

    Date.new!(year, month, selected_day)
  end
end
