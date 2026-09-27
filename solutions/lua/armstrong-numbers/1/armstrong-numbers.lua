local ArmstrongNumbers = {}

function ArmstrongNumbers.is_armstrong_number(number)
  local digits = tostring(number)
  local power = #digits
  local total = 0
  for index = 1, power do
    total = total + tonumber(digits:sub(index, index)) ^ power
  end
  return total == number
end

return ArmstrongNumbers
