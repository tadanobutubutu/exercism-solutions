local function is_palindrome(value)
  local text = tostring(value)
  return text == text:reverse()
end

local function search(minimum, maximum, descending)
  if minimum > maximum then error('min must be <= max') end
  local best, factors = nil, {}
  if descending then
    for a = maximum, minimum, -1 do
      if best and a * maximum < best then break end
      for b = maximum, a, -1 do
        local product = a * b
        if best and product < best then break end
        if is_palindrome(product) then
          if not best or product > best then best, factors = product, { { a, b } }
          elseif product == best then factors[#factors + 1] = { a, b } end
        end
      end
    end
  else
    for a = minimum, maximum do
      if best and a * a > best then break end
      for b = a, maximum do
        local product = a * b
        if best and product > best then break end
        if is_palindrome(product) then
          if not best or product < best then best, factors = product, { { a, b } }
          elseif product == best then factors[#factors + 1] = { a, b } end
        end
      end
    end
  end
  table.sort(factors, function(left, right)
    return left[1] == right[1] and left[2] < right[2] or left[1] < right[1]
  end)
  return { value = best, factors = factors }
end

local function smallest(minimum, maximum)
  return search(minimum, maximum, false)
end

local function largest(minimum, maximum)
  return search(minimum, maximum, true)
end

return { smallest = smallest, largest = largest }
