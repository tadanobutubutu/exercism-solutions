return {
  rotate = function(input, key)
    local shift = key % 26
    return (input:gsub('[A-Za-z]', function(character)
      local byte = string.byte(character)
      local base = byte >= string.byte('A') and byte <= string.byte('Z')
        and string.byte('A') or string.byte('a')
      return string.char((byte - base + shift) % 26 + base)
    end))
  end
}
