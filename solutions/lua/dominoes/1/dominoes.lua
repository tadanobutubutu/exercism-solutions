local function can_chain(dominoes)
  if #dominoes == 0 then return true end
  local graph, degree = {}, {}
  local vertices = 0
  local function ensure(value)
    if graph[value] == nil then
      graph[value] = {}
      degree[value] = 0
      vertices = vertices + 1
    end
  end

  for _, domino in ipairs(dominoes) do
    local left, right = domino[1], domino[2]
    ensure(left); ensure(right)
    graph[left][#graph[left] + 1] = right
    graph[right][#graph[right] + 1] = left
    if left == right then
      degree[left] = degree[left] + 2
    else
      degree[left] = degree[left] + 1
      degree[right] = degree[right] + 1
    end
  end
  for _, count in pairs(degree) do if count % 2 ~= 0 then return false end end

  local start = dominoes[1][1]
  local stack, visited = { start }, {}
  local seen = 0
  while #stack > 0 do
    local value = table.remove(stack)
    if not visited[value] then
      visited[value] = true
      seen = seen + 1
      for _, neighbor in ipairs(graph[value]) do
        if not visited[neighbor] then stack[#stack + 1] = neighbor end
      end
    end
  end
  return seen == vertices
end

return { can_chain = can_chain }
