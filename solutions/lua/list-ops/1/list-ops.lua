local function append(xs, ys)
  local result = {}
  for _, value in ipairs(xs) do result[#result + 1] = value end
  for _, value in ipairs(ys) do result[#result + 1] = value end
  return result
end

local function concat(...)
  local result = {}
  for i = 1, select('#', ...) do
    local list = select(i, ...)
    for _, value in ipairs(list) do result[#result + 1] = value end
  end
  return result
end

local function length(xs)
  return #xs
end

local function reverse(xs)
  local result = {}
  for i = #xs, 1, -1 do result[#result + 1] = xs[i] end
  return result
end

local function foldl(xs, value, f)
  for _, element in ipairs(xs) do value = f(value, element) end
  return value
end

local function foldr(xs, value, f)
  for i = #xs, 1, -1 do value = f(value, xs[i]) end
  return value
end

local function map(xs, f)
  local result = {}
  for i, value in ipairs(xs) do result[i] = f(value) end
  return result
end

local function filter(xs, predicate)
  local result = {}
  for _, value in ipairs(xs) do
    if predicate(value) then result[#result + 1] = value end
  end
  return result
end

return { append = append, concat = concat, length = length, reverse = reverse,
  map = map, foldl = foldl, foldr = foldr, filter = filter }
