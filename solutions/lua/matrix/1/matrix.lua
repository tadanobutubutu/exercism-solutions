return function(s)
  local rows = {}
  for line in s:gmatch('[^\n]+') do
    local row = {}
    for value in line:gmatch('%d+') do row[#row + 1] = tonumber(value) end
    rows[#rows + 1] = row
  end
  return {
    row = function(index)
      local copy = {}
      for column, value in ipairs(rows[index]) do copy[column] = value end
      return copy
    end,
    column = function(index)
      local column = {}
      for row = 1, #rows do column[row] = rows[row][index] end
      return column
    end,
  }
end
