require 'date'

class Meetup
  def initialize(month, year)
    @month = month
    @year = year
  end
  
  def day(weekday, schedule)
    first_day = Date.new(@year, @month, 1)
    weekday_num = weekday.is_a?(Symbol) ? Date::DAYNAMES.index(weekday.to_s.capitalize) : weekday
    first_weekday = first_day + ((weekday_num - first_day.wday) % 7)
    
    case schedule
    when :first
      first_weekday
    when :second
      first_weekday + 7
    when :third
      first_weekday + 14
    when :fourth
      first_weekday + 21
    when :teenth
      # Find the first day that is >= 13th and matches the weekday
      candidate = first_weekday
      while candidate.day < 13
        candidate += 7
      end
      candidate
    when :last
      last_day = Date.new(@year, @month, -1)
      last_weekday = last_day - ((last_day.wday - weekday_num) % 7)
      last_weekday
    end
  end
end
