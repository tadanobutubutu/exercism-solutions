local function annotate(garden)
  local result = {}
  for row = 1, #garden do
    local output = {}
    for column = 1, #garden[row] do
      local cell = garden[row]:sub(column, column)
      if cell == '*' then
        output[#output + 1] = '*'
      else
        local count = 0
        for r = row - 1, row + 1 do
          for c = column - 1, column + 1 do
            if (r ~= row or c ~= column) and garden[r]
              and garden[r]:sub(c, c) == '*' then count = count + 1 end
          end
        end
        output[#output + 1] = count == 0 and ' ' or tostring(count)
      end
    end
    result[row] = table.concat(output)
  end
  return result
end

return { annotate = annotate }
