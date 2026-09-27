return function(which)
  local size = string.byte(which) - string.byte('A') + 1
  local lines = {}
  local function line(index)
    local outer = string.rep(' ', size - index)
    local letter = string.char(string.byte('A') + index - 1)
    if index == 1 then return outer .. letter .. outer end
    return outer .. letter .. string.rep(' ', 2 * index - 3) .. letter .. outer
  end
  for index = 1, size do lines[#lines + 1] = line(index) end
  for index = size - 1, 1, -1 do lines[#lines + 1] = line(index) end
  return table.concat(lines, '\n') .. '\n'
end
