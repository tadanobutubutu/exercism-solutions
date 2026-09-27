return function(n)
  local values = {}
  for number = 2, n do values[number] = true end
  for factor = 2, math.floor(math.sqrt(n)) do
    if values[factor] then
      for composite = factor * factor, n, factor do values[composite] = false end
    end
  end
  return coroutine.create(function()
    for number = 2, n do
      if values[number] then coroutine.yield(number) end
    end
  end)
end
