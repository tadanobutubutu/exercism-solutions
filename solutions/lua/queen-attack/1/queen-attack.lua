return function(pos)
  local row, column = pos.row, pos.column
  if type(row) ~= 'number' or type(column) ~= 'number' or row % 1 ~= 0 or column % 1 ~= 0
    or row < 0 or row > 7 or column < 0 or column > 7 then
    error('invalid queen position')
  end
  return {
    row = row,
    column = column,
    can_attack = function(other)
      if row == other.row and column == other.column then return false end
      return row == other.row or column == other.column or math.abs(row - other.row) == math.abs(column - other.column)
    end,
  }
end
