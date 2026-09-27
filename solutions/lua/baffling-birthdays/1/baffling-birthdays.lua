local baffling_birthdays = {}

baffling_birthdays.shared_birthday = function(birthdates)
  local seen = {}
  for _, date in ipairs(birthdates) do
    local month_day = date:sub(6, 10)
    if seen[month_day] then return true end
    seen[month_day] = true
  end
  return false
end

baffling_birthdays.random_birthdates = function(count)
  local dates = {}
  for i = 1, count do
    local month = math.random(1, 12)
    local day = math.random(1, 31)
    dates[i] = string.format('2001-%02d-%02d', month, day)
  end
  return dates
end

baffling_birthdays.estimated_probability_of_shared_birthday = function(group_size)
  if group_size <= 1 then return 0 end
  if group_size > 365 then return 100 end
  local probability_unique = 1
  for i = 0, group_size - 1 do
    probability_unique = probability_unique * (365 - i) / 365
  end
  return (1 - probability_unique) * 100
end

return baffling_birthdays
