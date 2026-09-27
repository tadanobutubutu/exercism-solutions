return function(results)
  local teams = {}
  for _, line in ipairs(results) do
    local home, away, outcome = line:match('^([^;]+);([^;]+);([^;]+)$')
    if home and (outcome == 'win' or outcome == 'loss' or outcome == 'draw') then
      teams[home] = teams[home] or { played = 0, wins = 0, draws = 0, losses = 0, points = 0 }
      teams[away] = teams[away] or { played = 0, wins = 0, draws = 0, losses = 0, points = 0 }
      local h, a = teams[home], teams[away]
      h.played, a.played = h.played + 1, a.played + 1
      if outcome == 'win' then
        h.wins, h.points = h.wins + 1, h.points + 3
        a.losses = a.losses + 1
      elseif outcome == 'loss' then
        h.losses = h.losses + 1
        a.wins, a.points = a.wins + 1, a.points + 3
      else
        h.draws, a.draws = h.draws + 1, a.draws + 1
        h.points, a.points = h.points + 1, a.points + 1
      end
    end
  end

  local names = {}
  for name in pairs(teams) do names[#names + 1] = name end
  table.sort(names, function(left, right)
    local a, b = teams[left], teams[right]
    return a.points == b.points and left < right or a.points > b.points
  end)

  local table_rows = { 'Team                           | MP |  W |  D |  L |  P' }
  for _, name in ipairs(names) do
    local t = teams[name]
    table_rows[#table_rows + 1] = string.format('%-31s| %2d | %2d | %2d | %2d | %2d',
      name, t.played, t.wins, t.draws, t.losses, t.points)
  end
  return table_rows
end
