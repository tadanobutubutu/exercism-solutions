return function(n)
  if n < 1 or n % 1 ~= 0 then error('n must be positive') end
  local limit
  if n < 6 then limit = 15
  else limit = math.ceil(n * (math.log(n) + math.log(math.log(n))) + 10) end
  while true do
    local prime = {}
    for number = 2, limit do prime[number] = true end
    for factor = 2, math.floor(math.sqrt(limit)) do
      if prime[factor] then
        for composite = factor * factor, limit, factor do prime[composite] = false end
      end
    end
    local count = 0
    for number = 2, limit do
      if prime[number] then
        count = count + 1
        if count == n then return number end
      end
    end
    limit = limit * 2
  end
end
