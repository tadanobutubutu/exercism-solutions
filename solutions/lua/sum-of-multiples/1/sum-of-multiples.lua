return function(numbers)
  local factors = {}
  for _, factor in ipairs(numbers) do
    if factor ~= 0 then factors[#factors + 1] = math.abs(factor) end
  end
  return {
    to = function(limit)
      local total = 0
      for candidate = 1, limit - 1 do
        for _, factor in ipairs(factors) do
          if candidate % factor == 0 then
            total = total + candidate
            break
          end
        end
      end
      return total
    end,
  }
end
