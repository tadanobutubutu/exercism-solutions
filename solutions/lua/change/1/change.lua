return function(amount, values)
  if amount < 0 then error("target can't be negative") end
  if amount == 0 then return {} end
  local best = { [0] = 0 }
  local last_coin = {}
  for total = 1, amount do
    for _, coin in ipairs(values) do
      if coin > 0 and total >= coin and best[total - coin] ~= nil then
        local candidate = best[total - coin] + 1
        if best[total] == nil or candidate < best[total] then
          best[total] = candidate
          last_coin[total] = coin
        end
      end
    end
  end
  if best[amount] == nil then error("can't make target with given coins") end

  local result = {}
  local remaining = amount
  while remaining > 0 do
    local coin = last_coin[remaining]
    result[#result + 1] = coin
    remaining = remaining - coin
  end
  table.sort(result)
  return result
end
