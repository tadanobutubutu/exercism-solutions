local yacht = {}

function yacht.score(dice, category)
  local counts, sum = {}, 0
  for _, die in ipairs(dice) do
    counts[die] = (counts[die] or 0) + 1
    sum = sum + die
  end
  if category == 'yacht' then
    for _, count in pairs(counts) do if count == 5 then return 50 end end
    return 0
  elseif category == 'choice' then
    return sum
  elseif category == 'full house' then
    local has_pair, has_triple = false, false
    for _, count in pairs(counts) do
      if count == 2 then has_pair = true elseif count == 3 then has_triple = true end
    end
    return has_pair and has_triple and sum or 0
  elseif category == 'four of a kind' then
    for value, count in pairs(counts) do if count >= 4 then return value * 4 end end
    return 0
  elseif category == 'little straight' or category == 'big straight' then
    local low, high = category == 'little straight' and 1 or 2, category == 'little straight' and 5 or 6
    for value = low, high do if counts[value] ~= 1 then return 0 end end
    return 30
  end

  local number = ({ ones = 1, twos = 2, threes = 3, fours = 4, fives = 5, sixes = 6 })[category]
  return number and (counts[number] or 0) * number or 0
end

return yacht
