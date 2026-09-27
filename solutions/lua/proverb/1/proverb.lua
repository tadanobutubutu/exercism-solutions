local Proverb = {}

function Proverb.recite(strings)
  local verses = {}
  for index = 1, #strings - 1 do
    verses[#verses + 1] = 'For want of a ' .. strings[index] .. ' the ' .. strings[index + 1] .. ' was lost.\n'
  end
  if #strings > 0 then
    verses[#verses + 1] = 'And all for the want of a ' .. strings[1] .. '.\n'
  end
  return table.concat(verses)
end

return Proverb
