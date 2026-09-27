local function simulate_game(playerA, playerB)
  local decks = { {}, {} }
  for _, card in ipairs(playerA) do decks[1][#decks[1] + 1] = card end
  for _, card in ipairs(playerB) do decks[2][#decks[2] + 1] = card end
  local heads, tails = { 1, 1 }, { #decks[1], #decks[2] }
  local total_cards = #playerA + #playerB
  local cards_played, tricks, lead = 0, 0, 1
  local seen = {}

  local function size(player)
    return tails[player] - heads[player] + 1
  end

  local function card_key(player)
    local parts = {}
    for i = heads[player], tails[player] do
      local card = decks[player][i]
      parts[#parts + 1] = (card == 'J' or card == 'Q' or card == 'K' or card == 'A') and card or 'N'
    end
    return table.concat(parts, ',')
  end

  local function collect(winner, pile)
    tricks = tricks + 1
    for _, card in ipairs(pile) do
      tails[winner] = tails[winner] + 1
      decks[winner][tails[winner]] = card
    end
    if size(winner) == total_cards then
      return true
    end
    lead = winner
    return false
  end

  while true do
    local key = lead .. '|' .. card_key(1) .. '|' .. card_key(2)
    if seen[key] then
      return { status = 'loop', cards = cards_played, tricks = tricks }
    end
    seen[key] = true

    local pile, penalty, last_payment_player = {}, 0, nil
    local current = lead
    while true do
      if size(current) <= 0 then
        if collect(3 - current, pile) then
          return { status = 'finished', cards = cards_played, tricks = tricks }
        end
        break
      end

      local card = decks[current][heads[current]]
      heads[current] = heads[current] + 1
      pile[#pile + 1] = card
      cards_played = cards_played + 1

      local new_penalty = ({ J = 1, Q = 2, K = 3, A = 4 })[card]
      if new_penalty then
        penalty = new_penalty
        last_payment_player = current
        current = 3 - current
      elseif penalty > 0 then
        penalty = penalty - 1
        if penalty == 0 then
          if collect(last_payment_player, pile) then
            return { status = 'finished', cards = cards_played, tricks = tricks }
          end
          break
        end
      else
        current = 3 - current
      end
    end
  end
end

return { simulate_game = simulate_game }
