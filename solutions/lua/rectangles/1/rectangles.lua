local function at(grid, row, column)
  return (grid[row] or ''):sub(column, column)
end

local function horizontal(grid, row, left, right)
  for column = left + 1, right - 1 do
    local value = at(grid, row, column)
    if value ~= '-' and value ~= '+' then return false end
  end
  return true
end

local function vertical(grid, column, top, bottom)
  for row = top + 1, bottom - 1 do
    local value = at(grid, row, column)
    if value ~= '|' and value ~= '+' then return false end
  end
  return true
end

local function count(grid)
  local total = 0
  for top = 1, #grid do
    for bottom = top + 1, #grid do
      for left = 1, #(grid[top] or '') do
        if at(grid, top, left) == '+' and at(grid, bottom, left) == '+'
          and vertical(grid, left, top, bottom) then
          for right = left + 1, #(grid[top] or '') do
            if at(grid, top, right) == '+' and at(grid, bottom, right) == '+'
              and horizontal(grid, top, left, right)
              and horizontal(grid, bottom, left, right)
              and vertical(grid, right, top, bottom) then
              total = total + 1
            end
          end
        end
      end
    end
  end
  return total
end

return { count = count }
