return function(input)
  local factors = {}
  local divisor = 2
  while divisor * divisor <= input do
    while input % divisor == 0 do
      factors[#factors + 1] = divisor
      input = input / divisor
    end
    divisor = divisor == 2 and 3 or divisor + 2
  end
  if input > 1 then factors[#factors + 1] = input end
  return factors
end
