local function keep(xs, pred)
  local result = {}
  for _, value in ipairs(xs) do
    if pred(value) then result[#result + 1] = value end
  end
  return result
end

local function discard(xs, pred)
  local result = {}
  for _, value in ipairs(xs) do
    if not pred(value) then result[#result + 1] = value end
  end
  return result
end

return { keep = keep, discard = discard }
