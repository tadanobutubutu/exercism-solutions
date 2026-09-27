local function route(length, rail_count)
  local result, rail, direction = {}, 1, 1
  for i = 1, length do
    result[i] = rail
    if rail_count > 1 then
      if rail == 1 then direction = 1 elseif rail == rail_count then direction = -1 end
      rail = rail + direction
    end
  end
  return result
end

local function encode(plaintext, rail_count)
  if rail_count <= 1 or rail_count >= #plaintext then return plaintext end
  local rails = {}
  for i = 1, rail_count do rails[i] = {} end
  for i, rail in ipairs(route(#plaintext, rail_count)) do
    rails[rail][#rails[rail] + 1] = plaintext:sub(i, i)
  end
  local output = {}
  for _, chars in ipairs(rails) do output[#output + 1] = table.concat(chars) end
  return table.concat(output)
end

local function decode(ciphertext, rail_count)
  if rail_count <= 1 or rail_count >= #ciphertext then return ciphertext end
  local rails = {}
  for i = 1, rail_count do rails[i] = {} end
  local positions = route(#ciphertext, rail_count)
  for _, rail in ipairs(positions) do rails[rail][#rails[rail] + 1] = true end
  local offset = 1
  for rail = 1, rail_count do
    for i = 1, #rails[rail] do
      rails[rail][i] = ciphertext:sub(offset, offset)
      offset = offset + 1
    end
  end
  local indexes, output = {}, {}
  for rail = 1, rail_count do indexes[rail] = 0 end
  for _, rail in ipairs(positions) do
    indexes[rail] = indexes[rail] + 1
    output[#output + 1] = rails[rail][indexes[rail]]
  end
  return table.concat(output)
end

return { encode = encode, decode = decode }
