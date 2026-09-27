local function parse_board(board)
  local cells = {}
  for r, row in ipairs(board) do
    cells[r] = {}
    for cell in row:gmatch('[XO%.]') do cells[r][#cells[r] + 1] = cell end
  end
  return cells
end

local function has_path(cells, player)
  local height = #cells
  local width = 0
  for _, row in ipairs(cells) do width = math.max(width, #row) end
  local queue, seen, head = {}, {}, 1
  local function add(row, column)
    local key = row .. ':' .. column
    if row >= 1 and row <= height and column >= 1 and column <= width
      and cells[row][column] == player and not seen[key] then
      seen[key] = true
      queue[#queue + 1] = { row, column }
    end
  end

  if player == 'X' then
    for row = 1, height do add(row, 1) end
  else
    for column = 1, width do add(1, column) end
  end

  local neighbors = { { 0, -1 }, { 0, 1 }, { -1, 0 }, { -1, 1 }, { 1, -1 }, { 1, 0 } }
  while head <= #queue do
    local point = queue[head]
    head = head + 1
    local row, column = point[1], point[2]
    if (player == 'X' and column == width) or (player == 'O' and row == height) then
      return true
    end
    for _, offset in ipairs(neighbors) do
      add(row + offset[1], column + offset[2])
    end
  end
  return false
end

return {
  winner = function(board)
    local cells = parse_board(board)
    if has_path(cells, 'X') then return 'X' end
    if has_path(cells, 'O') then return 'O' end
    return ''
  end
}
