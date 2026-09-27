return function(s)
  if s == '' then return '' end
  local lines = {}
  for line in (s .. '\n'):gmatch('(.-)\n') do lines[#lines + 1] = line end
  local width = 0
  for _, line in ipairs(lines) do width = math.max(width, #line) end
  local result = {}
  for column = 1, width do
    local last_row = 0
    for row, line in ipairs(lines) do
      if #line >= column then last_row = row end
    end
    local chars = {}
    for row = 1, last_row do
      local line = lines[row]
      chars[row] = column <= #line and line:sub(column, column) or ' '
    end
    result[column] = table.concat(chars)
  end
  return table.concat(result, '\n')
end
