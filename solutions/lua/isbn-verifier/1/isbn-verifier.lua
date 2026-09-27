local function valid(isbn)
  if type(isbn) ~= 'string' then return false end
  local value = isbn:gsub('-', '')
  if #value ~= 10 then return false end
  if not value:sub(1, 9):match('^%d%d%d%d%d%d%d%d%d$') then return false end

  local check = value:sub(10, 10)
  if not check:match('^%d$') and check ~= 'X' then return false end
  local sum = 0
  for i = 1, 9 do
    sum = sum + tonumber(value:sub(i, i)) * (11 - i)
  end
  sum = sum + (check == 'X' and 10 or tonumber(check))
  return sum % 11 == 0
end

return { valid = valid }
