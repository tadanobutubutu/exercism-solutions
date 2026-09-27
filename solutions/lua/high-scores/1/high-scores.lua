local HighScores = {}

function HighScores:scores()
  local copy = {}
  for index, score in ipairs(self.values) do copy[index] = score end
  return copy
end

function HighScores:latest()
  return self.values[#self.values]
end

function HighScores:personal_best()
  local best
  for _, score in ipairs(self.values) do
    if best == nil or score > best then best = score end
  end
  return best
end

function HighScores:personal_top_three()
  local copy = self:scores()
  table.sort(copy, function(first, second) return first > second end)
  while #copy > 3 do table.remove(copy) end
  return copy
end

return function(scores)
  local high_scores = { values = scores }
  setmetatable(high_scores, { __index = HighScores })

  return high_scores
end
