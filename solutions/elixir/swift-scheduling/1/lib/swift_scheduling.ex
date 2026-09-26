defmodule SwiftScheduling do
  @doc """
  Convert delivery date descriptions to actual delivery dates, based on when the meeting started.
  """
  @spec delivery_date(NaiveDateTime.t(), String.t()) :: NaiveDateTime.t()
  def delivery_date(meeting_date, description) do
    case description do
      "NOW" -> NaiveDateTime.add(meeting_date, 2 * 60 * 60, :second)
      "ASAP" -> asap_date(meeting_date)
      "EOW" -> end_of_week(meeting_date)
      <<_::binary>> -> variable_date(meeting_date, description)
    end
  end

  defp asap_date(meeting_date) do
    date =
      if meeting_date.hour < 13 do
        NaiveDateTime.to_date(meeting_date)
      else
        meeting_date |> NaiveDateTime.to_date() |> Date.add(1)
      end

    {hour, minute} = if meeting_date.hour < 13, do: {17, 0}, else: {13, 0}
    at(date, hour, minute)
  end

  defp end_of_week(meeting_date) do
    date = NaiveDateTime.to_date(meeting_date)
    weekday = Date.day_of_week(date)
    days_to_end = if weekday <= 3, do: 5 - weekday, else: 7 - weekday
    target = Date.add(date, days_to_end)
    {hour, minute} = if weekday <= 3, do: {17, 0}, else: {20, 0}
    at(target, hour, minute)
  end

  defp variable_date(meeting_date, <<"Q", rest::binary>>) do
    {quarter, ""} = Integer.parse(rest)
    current_quarter = div(meeting_date.month - 1, 3) + 1
    year = meeting_date.year + if(current_quarter > quarter, do: 1, else: 0)
    month = quarter * 3
    last_day = Date.end_of_month(Date.new!(year, month, 1))
    weekday = Date.day_of_week(last_day)

    delivery_day =
      Date.add(last_day, if(weekday == 6, do: -1, else: if(weekday == 7, do: -2, else: 0)))

    at(delivery_day, 8, 0)
  end

  defp variable_date(meeting_date, description) do
    {month, ""} = description |> String.trim_trailing("M") |> Integer.parse()
    year = meeting_date.year + if(meeting_date.month >= month, do: 1, else: 0)
    first_day = Date.new!(year, month, 1)

    first_workday =
      case Date.day_of_week(first_day) do
        6 -> Date.add(first_day, 2)
        7 -> Date.add(first_day, 1)
        _ -> first_day
      end

    at(first_workday, 8, 0)
  end

  defp at(date, hour, minute), do: NaiveDateTime.new!(date, Time.new!(hour, minute, 0))
end
