return function(config)
  local weekdays = {
    Sunday = 0, Monday = 1, Tuesday = 2, Wednesday = 3,
    Thursday = 4, Friday = 5, Saturday = 6
  }
  local offsets = { 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4 }
  local function weekday(year, month, day)
    if month < 3 then year = year - 1 end
    return (year + math.floor(year / 4) - math.floor(year / 100) + math.floor(year / 400)
      + offsets[month] + day) % 7
  end

  local days_in_month = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
  local year, month = config.year, config.month
  if month == 2 and (year % 400 == 0 or (year % 4 == 0 and year % 100 ~= 0)) then
    days_in_month[2] = 29
  end
  local target = assert(weekdays[config.day], 'unknown weekday')
  local week = config.week
  if week == 'teenth' then return 13 + (target - weekday(year, month, 13)) % 7 end

  local first = 1 + (target - weekday(year, month, 1)) % 7
  if week == 'first' then return first end
  if week == 'second' then return first + 7 end
  if week == 'third' then return first + 14 end
  if week == 'fourth' then return first + 21 end
  if week == 'last' then
    local last = days_in_month[month]
    return last - (weekday(year, month, last) - target) % 7
  end
  error('unknown week')
end
