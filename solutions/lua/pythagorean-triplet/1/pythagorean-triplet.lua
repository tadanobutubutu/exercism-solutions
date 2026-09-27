return function(sum)
  local triplets = {}
  for a = 1, math.floor(sum / 3) do
    local numerator = sum * (sum - 2 * a)
    local denominator = 2 * (sum - a)
    if numerator % denominator == 0 then
      local b = numerator / denominator
      local c = sum - a - b
      if a < b and b < c and a * a + b * b == c * c then
        triplets[#triplets + 1] = { a, b, c }
      end
    end
  end
  return triplets
end
