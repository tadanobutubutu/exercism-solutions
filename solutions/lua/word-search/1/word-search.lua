local directions = {
  { 1, 0 }, { -1, 0 }, { 0, 1 }, { 0, -1 },
  { 1, 1 }, { 1, -1 }, { -1, 1 }, { -1, -1 }
}

return function(grid)
  local height, width = #grid, #(grid[1] or '')
  local function search(words)
    local found = {}
    for _, word in ipairs(words) do
      for row = 1, height do
        for column = 1, width do
          if grid[row]:sub(column, column) == word:sub(1, 1) then
            for _, direction in ipairs(directions) do
              local dc, dr = direction[1], direction[2]
              local end_column = column + dc * (#word - 1)
              local end_row = row + dr * (#word - 1)
              if end_column >= 1 and end_column <= width and end_row >= 1 and end_row <= height then
                local matches = true
                for i = 2, #word do
                  if grid[row + dr * (i - 1)]:sub(column + dc * (i - 1), column + dc * (i - 1)) ~= word:sub(i, i) then
                    matches = false
                    break
                  end
                end
                if matches then
                  found[word] = { start = { column, row }, ['end'] = { end_column, end_row } }
                  break
                end
              end
            end
          end
          if found[word] then break end
        end
        if found[word] then break end
      end
    end
    return found
  end
  return { search = search }
end
