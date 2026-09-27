local house = {}

local nouns = {
  'the house', 'the malt', 'the rat', 'the cat', 'the dog',
  'the cow with the crumpled horn', 'the maiden all forlorn',
  'the man all tattered and torn', 'the priest all shaven and shorn',
  'the rooster that crowed in the morn', 'the farmer sowing his corn',
  'the horse and the hound and the horn'
}
local links = {
  [2] = 'that lay in', [3] = 'that ate', [4] = 'that killed',
  [5] = 'that worried', [6] = 'that tossed', [7] = 'that milked',
  [8] = 'that kissed', [9] = 'that married', [10] = 'that woke',
  [11] = 'that kept', [12] = 'that belonged to'
}

house.verse = function(which)
  local lines = { 'This is ' .. nouns[which] }
  for i = which, 2, -1 do
    local line = links[i] .. ' ' .. nouns[i - 1]
    if i == 2 then line = line .. ' that Jack built.' end
    lines[#lines + 1] = line
  end
  if which == 1 then lines[1] = lines[1] .. ' that Jack built.' end
  return table.concat(lines, '\n')
end

house.recite = function()
  local result = {}
  for i = 1, #nouns do result[i] = house.verse(i) end
  return table.concat(result, '\n')
end

return house
