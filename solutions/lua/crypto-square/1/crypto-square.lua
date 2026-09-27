return {
  ciphertext = function(plaintext)
    local normalized = plaintext:lower():gsub('[^%w]', '')
    local length = #normalized
    if length == 0 then return '' end
    local rows = math.floor(math.sqrt(length))
    local columns = math.ceil(math.sqrt(length))
    if rows * columns < length then rows = columns end
    local chunks = {}
    for column = 1, columns do
      local characters = {}
      for row = 1, rows do
        local index = (row - 1) * columns + column
        characters[row] = normalized:sub(index, index)
        if characters[row] == '' then characters[row] = ' ' end
      end
      chunks[column] = table.concat(characters)
    end
    return table.concat(chunks, ' ')
  end
}
