local Hamming = {}

function Hamming.compute(a, b)
  if #a ~= #b then
    error('strands must be of equal length')
  end
  local distance = 0
  for index = 1, #a do
    if a:sub(index, index) ~= b:sub(index, index) then
      distance = distance + 1
    end
  end
  return distance
end

return Hamming
