require "date"

class Meetup
  WEEKDAYS = %i[sunday monday tuesday wednesday thursday friday saturday]

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, schedule)
    target_wday = WEEKDAYS.index(weekday)
    first = Date.new(@year, @month, 1)
    days_in_month = Date.new(@year, @month, -1).day

    case schedule
    when :teenth
      first_teenth = Date.new(@year, @month, 13)
      days_to_add = (target_wday - first_teenth.wday) % 7
      Date.new(@year, @month, 13 + days_to_add)
    when :first
      days_to_add = (target_wday - first.wday) % 7
      Date.new(@year, @month, 1 + days_to_add)
    when :second
      days_to_add = (target_wday - first.wday) % 7
      Date.new(@year, @month, 1 + days_to_add + 7)
    when :third
      days_to_add = (target_wday - first.wday) % 7
      Date.new(@year, @month, 1 + days_to_add + 14)
    when :fourth
      days_to_add = (target_wday - first.wday) % 7
      Date.new(@year, @month, 1 + days_to_add + 21)
    when :last
      result = Date.new(@year, @month, 1 + (target_wday - first.wday) % 7)
      result += 7 while result.month == @month
      result - 7
    end
  end
end