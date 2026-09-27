return function(size)
  local matrix = {}
  for row = 1, size do
    matrix[row] = {}
    for column = 1, size do matrix[row][column] = 0 end
  end
  local top, bottom, left, right = 1, size, 1, size
  local value = 1
  while top <= bottom and left <= right do
    for column = left, right do matrix[top][column] = value; value = value + 1 end
    top = top + 1
    for row = top, bottom do matrix[row][right] = value; value = value + 1 end
    right = right - 1
    if top <= bottom then
      for column = right, left, -1 do matrix[bottom][column] = value; value = value + 1 end
      bottom = bottom - 1
    end
    if left <= right then
      for row = bottom, top, -1 do matrix[row][left] = value; value = value + 1 end
      left = left + 1
    end
  end
  return matrix
end
