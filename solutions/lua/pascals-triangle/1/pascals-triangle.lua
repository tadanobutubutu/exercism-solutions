return function(n)
  local rows = {}
  for row_index = 1, n do
    local row = { 1 }
    for column = 2, row_index - 1 do
      row[column] = rows[row_index - 1][column - 1] + rows[row_index - 1][column]
    end
    if row_index > 1 then row[row_index] = 1 end
    rows[row_index] = row
  end
  local last_row = rows[#rows] or {}
  return { rows = rows, last_row = last_row }
end
