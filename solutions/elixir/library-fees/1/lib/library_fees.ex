defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, datetime, _offset} = DateTime.from_iso8601(string)
    DateTime.to_naive(datetime)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    days_to_return = if before_noon?(checkout_datetime), do: 28, else: 29
    Date.add(NaiveDateTime.to_date(checkout_datetime), days_to_return)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = NaiveDateTime.to_date(actual_return_datetime)

    case Date.compare(actual_return_date, planned_return_date) do
      :gt -> Date.diff(actual_return_date, planned_return_date)
      _ -> 0
    end
  end

  def monday?(datetime) do
    Date.day_of_week(NaiveDateTime.to_date(datetime)) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    actual_return_datetime = datetime_from_string(return)
    late_days = days_late(return_date(checkout_datetime), actual_return_datetime)
    fee = late_days * rate

    if monday?(actual_return_datetime), do: div(fee, 2), else: fee
  end
end
