return function(n)
  if n < 1 or n % 1 ~= 0 then error('input must be a positive integer') end
  local steps = 0
  while n ~= 1 do
    if n % 2 == 0 then
      n = n / 2
    else
      n = 3 * n + 1
    end
    steps = steps + 1
  end
  return steps
end
