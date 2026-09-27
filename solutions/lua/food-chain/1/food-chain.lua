local animals = {
  { 'fly', "I don't know why she swallowed the fly. Perhaps she'll die." },
  { 'spider', 'It wriggled and jiggled and tickled inside her.' },
  { 'bird', 'How absurd to swallow a bird!' },
  { 'cat', 'Imagine that, to swallow a cat!' },
  { 'dog', 'What a hog, to swallow a dog!' },
  { 'goat', 'Just opened her throat and swallowed a goat!' },
  { 'cow', "I don't know how she swallowed a cow!" },
  { 'horse', "She's dead, of course!" }
}

local function verse(which)
  local animal = animals[which]
  local lines = { 'I know an old lady who swallowed a ' .. animal[1] .. '.' }
  if which == 8 then
    lines[#lines + 1] = animal[2]
  else
    if which > 1 then lines[#lines + 1] = animal[2] end
    for i = which, 2, -1 do
      local prey = animals[i - 1][1]
      local detail = prey == 'spider' and ' that wriggled and jiggled and tickled inside her' or ''
      lines[#lines + 1] = 'She swallowed the ' .. animals[i][1] .. ' to catch the ' .. prey .. detail .. '.'
    end
    lines[#lines + 1] = animals[1][2]
  end
  return table.concat(lines, '\n') .. '\n'
end

local function verses(from, to)
  local result = {}
  for i = from, to do result[#result + 1] = verse(i) end
  return table.concat(result, '\n') .. '\n'
end

local function sing()
  return verses(1, #animals)
end

return { verse = verse, verses = verses, sing = sing }
