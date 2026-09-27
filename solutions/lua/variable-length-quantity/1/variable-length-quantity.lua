local function encode(values)
  local bytes = {}
  for _, value in ipairs(values) do
    local groups = {}
    repeat
      groups[#groups + 1] = value % 128
      value = math.floor(value / 128)
    until value == 0
    for i = #groups, 1, -1 do
      local byte = groups[i]
      if i > 1 then byte = byte + 128 end
      bytes[#bytes + 1] = byte
    end
  end
  return bytes
end

local function decode(bytes)
  local values, value, in_sequence = {}, 0, false
  for _, byte in ipairs(bytes) do
    in_sequence = true
    value = value * 128 + (byte % 128)
    if byte < 128 then
      values[#values + 1] = value
      value, in_sequence = 0, false
    end
  end
  if in_sequence then error('incomplete variable-length quantity') end
  return values
end

return { encode = encode, decode = decode }
