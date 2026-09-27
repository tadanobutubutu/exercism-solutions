return function(array, target)
  local low, high = 1, #array
  while low <= high do
    local middle = math.floor((low + high) / 2)
    local value = array[middle]
    if value == target then return middle end
    if value < target then
      low = middle + 1
    else
      high = middle - 1
    end
  end
  return -1
end
