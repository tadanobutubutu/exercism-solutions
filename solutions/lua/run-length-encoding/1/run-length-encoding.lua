local function encode(input)
  local output = {}
  local i = 1
  while i <= #input do
    local j = i + 1
    while j <= #input and input:sub(j, j) == input:sub(i, i) do j = j + 1 end
    local count = j - i
    if count > 1 then output[#output + 1] = tostring(count) end
    output[#output + 1] = input:sub(i, i)
    i = j
  end
  return table.concat(output)
end

local function decode(input)
  local output = {}
  local i = 1
  while i <= #input do
    local start, finish, count = input:find('^(%d+)', i)
    if start then
      i = finish + 1
    else
      count = '1'
    end
    if i <= #input then
      output[#output + 1] = string.rep(input:sub(i, i), tonumber(count))
      i = i + 1
    end
  end
  return table.concat(output)
end

return { encode = encode, decode = decode }
