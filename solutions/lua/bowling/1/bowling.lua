return function()
  local game = { rolls = {}, frames = {}, frame = 1, current = {}, done = false }

  function game.roll(pins)
    if game.done then error('cannot roll after the game is over') end
    if type(pins) ~= 'number' or pins % 1 ~= 0 or pins < 0 or pins > 10 then
      error('pins must be an integer from 0 to 10')
    end

    if game.frame < 10 then
      if #game.current == 0 then
        game.current[1] = pins
        game.rolls[#game.rolls + 1] = pins
        if pins == 10 then
          game.frames[game.frame] = game.current
          game.frame = game.frame + 1
          game.current = {}
        end
      else
        if game.current[1] + pins > 10 then error('a frame cannot score more than 10 pins') end
        game.current[2] = pins
        game.rolls[#game.rolls + 1] = pins
        game.frames[game.frame] = game.current
        game.frame = game.frame + 1
        game.current = {}
      end
      return
    end

    local count = #game.current
    if count == 0 then
      game.current[1] = pins
    elseif count == 1 then
      if game.current[1] < 10 and game.current[1] + pins > 10 then
        error('a frame cannot score more than 10 pins')
      end
      game.current[2] = pins
      if game.current[1] < 10 and game.current[1] + pins < 10 then
        game.frames[10] = game.current
        game.done = true
      end
    else
      if game.current[1] == 10 and game.current[2] < 10 and game.current[2] + pins > 10 then
        error('fill balls cannot score more than 10 pins')
      end
      game.current[3] = pins
      game.frames[10] = game.current
      game.done = true
    end
    game.rolls[#game.rolls + 1] = pins
  end

  function game.score()
    if not game.done then error('cannot score an incomplete game') end
    local total, index = 0, 1
    for frame = 1, 10 do
      local first = game.rolls[index]
      if first == 10 then
        total = total + 10 + game.rolls[index + 1] + game.rolls[index + 2]
        index = index + 1
      elseif first + game.rolls[index + 1] == 10 then
        total = total + 10 + game.rolls[index + 2]
        index = index + 2
      else
        total = total + first + game.rolls[index + 1]
        index = index + 2
      end
    end
    return total
  end

  return game
end
