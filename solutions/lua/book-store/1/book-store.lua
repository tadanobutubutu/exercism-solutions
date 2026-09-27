local discounts = { [1] = 0, [2] = 0.05, [3] = 0.10, [4] = 0.20, [5] = 0.25 }
local groups = {}
for mask = 1, 31 do
  local books = {}
  for i = 1, 5 do
    if math.floor(mask / (2 ^ (i - 1))) % 2 == 1 then books[#books + 1] = i end
  end
  groups[#groups + 1] = books
end
table.sort(groups, function(a, b) return #a > #b end)

local function total(basket)
  local counts = { 0, 0, 0, 0, 0 }
  for _, book in ipairs(basket) do
    if book < 1 or book > 5 then error('book number must be between 1 and 5') end
    counts[book] = counts[book] + 1
  end
  local memo = {}
  local function cheapest()
    local key = table.concat(counts, ',')
    if memo[key] then return memo[key] end
    local remaining = 0
    for i = 1, 5 do remaining = remaining + counts[i] end
    if remaining == 0 then return 0 end

    local best = math.huge
    for _, group in ipairs(groups) do
      local possible = true
      for _, book in ipairs(group) do
        if counts[book] == 0 then possible = false; break end
      end
      if possible then
        for _, book in ipairs(group) do counts[book] = counts[book] - 1 end
        local size = #group
        local price = size * 800 * (1 - discounts[size]) + cheapest()
        if price < best then best = price end
        for _, book in ipairs(group) do counts[book] = counts[book] + 1 end
      end
    end
    memo[key] = best
    return best
  end
  return cheapest()
end

return { total = total }
