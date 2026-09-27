local ones = { 'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine' }
local teens = { 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen' }
local tens = { '', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety' }
local scales = { 'billion', 'million', 'thousand', '' }

local function under_thousand(value)
  local parts = {}
  if value >= 100 then
    parts[#parts + 1] = ones[math.floor(value / 100) + 1] .. ' hundred'
    value = value % 100
  end
  if value >= 20 then
    local phrase = tens[math.floor(value / 10) + 1]
    if value % 10 > 0 then phrase = phrase .. '-' .. ones[value % 10 + 1] end
    parts[#parts + 1] = phrase
  elseif value >= 10 then
    parts[#parts + 1] = teens[value - 9]
  elseif value > 0 then
    parts[#parts + 1] = ones[value + 1]
  end
  return table.concat(parts, ' ')
end

return function(number)
  if number < 0 or number > 999999999999 or number % 1 ~= 0 then return -1 end
  if number == 0 then return 'zero' end
  local parts = {}
  local divisors = { 1000000000, 1000000, 1000, 1 }
  for i, divisor in ipairs(divisors) do
    local group = math.floor(number / divisor) % 1000
    if group > 0 then
      parts[#parts + 1] = under_thousand(group)
      if scales[i] ~= '' then parts[#parts + 1] = scales[i] end
    end
  end
  return table.concat(parts, ' ')
end
