local function transmit_sequence(sequence)
  local bits = {}
  for _, byte in ipairs(sequence) do
    for shift = 7, 0, -1 do
      bits[#bits + 1] = (byte >> shift) & 1
    end
  end

  local result = {}
  for start = 1, #bits, 7 do
    local value, ones = 0, 0
    for offset = 0, 6 do
      local bit = bits[start + offset] or 0
      value = (value << 1) | bit
      ones = ones + bit
    end
    local parity = ones % 2
    result[#result + 1] = (value << 1) | parity
  end
  return result
end

local function decode_message(message)
  local bits = {}
  for _, byte in ipairs(message) do
    local value, ones = byte, 0
    while value > 0 do
      ones = ones + (value & 1)
      value = value >> 1
    end
    if ones % 2 ~= 0 then error('wrong parity') end
    local data = byte >> 1
    for shift = 6, 0, -1 do
      bits[#bits + 1] = (data >> shift) & 1
    end
  end

  local byte_count = math.floor(#bits / 8)
  local result = {}
  for index = 1, byte_count do
    local value = 0
    for offset = 0, 7 do
      value = (value << 1) | bits[(index - 1) * 8 + offset + 1]
    end
    result[index] = value
  end
  return result
end

return { transmit_sequence = transmit_sequence, decode_message = decode_message }
