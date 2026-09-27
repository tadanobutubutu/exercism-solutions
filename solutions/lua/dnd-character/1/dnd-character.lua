local Character = {}
Character.__index = Character

local function ability(scores)
  local rolls = {}
  for i = 1, 4 do rolls[i] = math.random(1, 6) end
  table.sort(rolls)
  return rolls[2] + rolls[3] + rolls[4]
end

local function modifier(input)
  return math.floor((input - 10) / 2)
end

function Character:new(name)
  local character = {
    name = name,
    strength = ability(),
    dexterity = ability(),
    constitution = ability(),
    intelligence = ability(),
    wisdom = ability(),
    charisma = ability()
  }
  character.hitpoints = 10 + modifier(character.constitution)
  return setmetatable(character, self)
end

return { Character = Character, ability = ability, modifier = modifier }
