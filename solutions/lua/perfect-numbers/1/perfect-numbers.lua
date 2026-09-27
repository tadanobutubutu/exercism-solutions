local function aliquot_sum(n)
  if n <= 1 then return 0 end
  local sum = 1
  for divisor = 2, math.floor(math.sqrt(n)) do
    if n % divisor == 0 then
      sum = sum + divisor
      local partner = n / divisor
      if partner ~= divisor then sum = sum + partner end
    end
  end
  return sum
end

local function classify(n)
  if n <= 0 or n % 1 ~= 0 then error('number must be a positive integer') end
  local sum = aliquot_sum(n)
  if sum == n then return 'perfect' end
  if sum > n then return 'abundant' end
  return 'deficient'
end

return { aliquot_sum = aliquot_sum, classify = classify }
