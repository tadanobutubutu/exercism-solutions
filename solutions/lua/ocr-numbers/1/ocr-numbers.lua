return {
  convert = function(s)
    local lines, position = {}, 1
    while position <= #s do
      local newline = s:find('\n', position, true)
      if newline then
        lines[#lines + 1] = s:sub(position, newline - 1)
        position = newline + 1
      else
        lines[#lines + 1] = s:sub(position)
        break
      end
    end
    assert(#lines > 0 and #lines % 4 == 0, 'invalid input height')
    local width = #lines[1]
    assert(width > 0 and width % 3 == 0, 'invalid input width')
    for _, line in ipairs(lines) do assert(#line == width, 'inconsistent line width') end

    local digits = {
      [' _ | ||_|   '] = '0',
      ['     |  |   '] = '1',
      [' _  _||_    '] = '2',
      [' _  _| _|   '] = '3',
      ['   |_|  |   '] = '4',
      [' _ |_  _|   '] = '5',
      [' _ |_ |_|   '] = '6',
      [' _   |  |   '] = '7',
      [' _ |_||_|   '] = '8',
      [' _ |_| _|   '] = '9'
    }
    local rows = {}
    for row = 1, #lines, 4 do
      local converted = {}
      for column = 1, width, 3 do
        local glyph = table.concat({
          lines[row]:sub(column, column + 2),
          lines[row + 1]:sub(column, column + 2),
          lines[row + 2]:sub(column, column + 2),
          lines[row + 3]:sub(column, column + 2)
        })
        converted[#converted + 1] = digits[glyph] or '?'
      end
      rows[#rows + 1] = table.concat(converted)
    end
    return table.concat(rows, ',')
  end
}
