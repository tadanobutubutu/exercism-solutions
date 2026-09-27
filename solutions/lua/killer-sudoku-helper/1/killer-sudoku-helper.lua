local function combinations(sum, size, exclude)
  local result, current = {}, {}
  local blocked = {}
  for _, digit in ipairs(exclude or {}) do blocked[digit] = true end

  local function search(next_digit, remaining, remaining_sum)
    if remaining == 0 then
      if remaining_sum == 0 then
        local combination = {}
        for i, digit in ipairs(current) do combination[i] = digit end
        result[#result + 1] = combination
      end
      return
    end
    if 10 - next_digit < remaining then return end

    local minimum = remaining * (2 * next_digit + remaining - 1) / 2
    local maximum = remaining * (19 - remaining) / 2
    if remaining_sum < minimum or remaining_sum > maximum then return end

    for digit = next_digit, 9 do
      if not blocked[digit] then
        current[#current + 1] = digit
        search(digit + 1, remaining - 1, remaining_sum - digit)
        current[#current] = nil
      end
    end
  end

  if size >= 1 and size <= 9 then search(1, size, sum) end
  return result
end

return { combinations = combinations }
