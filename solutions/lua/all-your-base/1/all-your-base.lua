local all_your_base = {}

all_your_base.convert = function(from_digits, from_base)
  if from_base < 2 then error('invalid input base') end
  local value = 0
  for _, digit in ipairs(from_digits) do
    if digit < 0 then error('negative digits are not allowed') end
    if digit >= from_base then error('digit out of range') end
    value = value * from_base + digit
  end
  return {
    to = function(to_base)
      if to_base < 2 then error('invalid output base') end
      if value == 0 then return { 0 } end
      local reversed = {}
      while value > 0 do
        reversed[#reversed + 1] = value % to_base
        value = math.floor(value / to_base)
      end
      local result = {}
      for index = #reversed, 1, -1 do result[#result + 1] = reversed[index] end
      return result
    end,
  }
end

return all_your_base
