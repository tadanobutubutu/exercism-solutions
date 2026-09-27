local function encode(phrase)
  local transformed = {}
  for char in phrase:lower():gmatch('[a-z0-9]') do
    if char >= 'a' and char <= 'z' then
      transformed[#transformed + 1] = string.char(string.byte('z') - string.byte(char) + string.byte('a'))
    else
      transformed[#transformed + 1] = char
    end
  end
  local groups = {}
  for i = 1, #transformed, 5 do
    groups[#groups + 1] = table.concat(transformed, '', i, math.min(i + 4, #transformed))
  end
  return table.concat(groups, ' ')
end

local function decode(phrase)
  local transformed = {}
  for char in phrase:lower():gmatch('[a-z0-9]') do
    if char >= 'a' and char <= 'z' then
      transformed[#transformed + 1] = string.char(string.byte('z') - string.byte(char) + string.byte('a'))
    else
      transformed[#transformed + 1] = char
    end
  end
  return table.concat(transformed)
end

return { encode = encode, decode = decode }
