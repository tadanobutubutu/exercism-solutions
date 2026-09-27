return function(n)
  local actions = { 'wink', 'double blink', 'close your eyes', 'jump' }
  local result = {}
  for bit = 1, 4 do
    if math.floor(n / (2 ^ (bit - 1))) % 2 == 1 then
      result[#result + 1] = actions[bit]
    end
  end
  if math.floor(n / 16) % 2 == 1 then
    local reversed = {}
    for index = #result, 1, -1 do
      reversed[#reversed + 1] = result[index]
    end
    return reversed
  end
  return result
end
