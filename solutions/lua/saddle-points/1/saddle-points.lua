return function(matrix)
  local result = {}
  if #matrix == 0 or #matrix[1] == 0 then return result end
  local columns, row_maxima, col_minima = #matrix[1], {}, {}
  for r, row in ipairs(matrix) do
    local maximum = row[1]
    for c = 2, columns do if row[c] > maximum then maximum = row[c] end end
    row_maxima[r] = maximum
  end
  for c = 1, columns do
    local minimum = matrix[1][c]
    for r = 2, #matrix do if matrix[r][c] < minimum then minimum = matrix[r][c] end end
    col_minima[c] = minimum
  end
  for r, row in ipairs(matrix) do
    for c, value in ipairs(row) do
      if value == row_maxima[r] and value == col_minima[c] then
        result[#result + 1] = { row = r, column = c }
      end
    end
  end
  return result
end
