local EliudsEggs = {}

function EliudsEggs.egg_count(number)
  local count = 0
  while number > 0 do
    count = count + number % 2
    number = math.floor(number / 2)
  end
  return count
end

return EliudsEggs
