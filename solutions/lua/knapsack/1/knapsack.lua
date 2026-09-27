local function maximum_value(maximum_weight, items)
  local best = {}
  for weight = 0, maximum_weight do best[weight] = 0 end
  for _, item in ipairs(items) do
    for weight = maximum_weight, item.weight, -1 do
      local candidate = best[weight - item.weight] + item.value
      if candidate > best[weight] then best[weight] = candidate end
    end
  end
  local answer = 0
  for weight = 0, maximum_weight do
    if best[weight] > answer then answer = best[weight] end
  end
  return answer
end

return { maximum_value = maximum_value }
