local Darts = {}

function Darts.score(x, y)
  local distance_squared = x * x + y * y
  if distance_squared <= 1 then return 10 end
  if distance_squared <= 25 then return 5 end
  if distance_squared <= 100 then return 1 end
  return 0
end

return Darts
