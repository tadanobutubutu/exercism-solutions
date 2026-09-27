local function tick(matrix)
  local rows = #matrix
  if rows == 0 then return {} end
  local columns = #matrix[1]
  local next_matrix = {}
  for row = 1, rows do
    next_matrix[row] = {}
    for column = 1, columns do
      local neighbors = 0
      for r = row - 1, row + 1 do
        for c = column - 1, column + 1 do
          if (r ~= row or c ~= column) and matrix[r] and matrix[r][c] == 1 then
            neighbors = neighbors + 1
          end
        end
      end
      local alive = matrix[row][column] == 1
      local survives = (alive and (neighbors == 2 or neighbors == 3))
        or (not alive and neighbors == 3)
      next_matrix[row][column] = survives and 1 or 0
    end
  end
  return next_matrix
end

return { tick = tick }
