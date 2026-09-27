local function mod(value, modulus)
  return ((value % modulus) + modulus) % modulus
end

local function gcd(a, b)
  while b ~= 0 do
    a, b = b, a % b
  end
  return a
end

local function inverse(a, modulus)
  local old_r, r = a, modulus
  local old_s, s = 1, 0
  while r ~= 0 do
    local quotient = math.floor(old_r / r)
    old_r, r = r, old_r - quotient * r
    old_s, s = s, old_s - quotient * s
  end
  return mod(old_s, modulus)
end

local function validate_key(key)
  local a = mod(key.a, 26)
  if gcd(a, 26) ~= 1 then
    error('a and m must be coprime.')
  end
  return a, mod(key.b, 26)
end

local function encode(phrase, key)
  local a, b = validate_key(key)
  local output = {}
  for i = 1, #phrase do
    local byte = phrase:byte(i)
    if byte >= 65 and byte <= 90 then
      byte = byte + 32
    end
    if byte >= 97 and byte <= 122 then
      output[#output + 1] = string.char(97 + mod(a * (byte - 97) + b, 26))
    elseif byte >= 48 and byte <= 57 then
      output[#output + 1] = string.char(byte)
    end
  end

  local encoded = table.concat(output)
  local groups = {}
  for i = 1, #encoded, 5 do
    groups[#groups + 1] = encoded:sub(i, i + 4)
  end
  return table.concat(groups, ' ')
end

local function decode(phrase, key)
  local a, b = validate_key(key)
  local a_inverse = inverse(a, 26)
  local output = {}
  for i = 1, #phrase do
    local byte = phrase:byte(i)
    if byte >= 65 and byte <= 90 then
      byte = byte + 32
    end
    if byte >= 97 and byte <= 122 then
      output[#output + 1] = string.char(97 + mod(a_inverse * ((byte - 97) - b), 26))
    elseif byte >= 48 and byte <= 57 then
      output[#output + 1] = string.char(byte)
    end
  end
  return table.concat(output)
end

return { encode = encode, decode = decode }
