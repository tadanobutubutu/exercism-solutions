local function gamestate(board)
  if type(board) ~= 'table' or #board ~= 3 then error('invalid board') end
  local x_count, o_count = 0, 0
  for _, row in ipairs(board) do
    if type(row) ~= 'string' or #row ~= 3 or row:find('[^XO ]') then error('invalid board') end
    x_count = x_count + select(2, row:gsub('X', ''))
    o_count = o_count + select(2, row:gsub('O', ''))
  end
  if not (x_count == o_count or x_count == o_count + 1) then error('invalid board') end

  local lines = {
    { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 },
    { 1, 4, 7 }, { 2, 5, 8 }, { 3, 6, 9 },
    { 1, 5, 9 }, { 3, 5, 7 }
  }
  local cells = table.concat(board)
  local x_wins, o_wins = false, false
  for _, line in ipairs(lines) do
    local first = cells:sub(line[1], line[1])
    if first ~= ' ' and cells:sub(line[2], line[2]) == first and cells:sub(line[3], line[3]) == first then
      if first == 'X' then x_wins = true else o_wins = true end
    end
  end
  if x_wins and o_wins then error('invalid board') end
  if x_wins then
    if x_count ~= o_count + 1 then error('invalid board') end
    return 'win'
  end
  if o_wins then
    if x_count ~= o_count then error('invalid board') end
    return 'win'
  end
  if x_count + o_count == 9 then return 'draw' end
  return 'ongoing'
end

return { gamestate = gamestate }
