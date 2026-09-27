local function recite(start_verse, end_verse)
  local ordinals = {
    'first', 'second', 'third', 'fourth', 'fifth', 'sixth',
    'seventh', 'eighth', 'ninth', 'tenth', 'eleventh', 'twelfth',
  }
  local gifts = {
    'a Partridge in a Pear Tree', 'two Turtle Doves', 'three French Hens',
    'four Calling Birds', 'five Gold Rings', 'six Geese-a-Laying',
    'seven Swans-a-Swimming', 'eight Maids-a-Milking', 'nine Ladies Dancing',
    'ten Lords-a-Leaping', 'eleven Pipers Piping', 'twelve Drummers Drumming',
  }
  local verses = {}
  for day = start_verse, end_verse do
    local lines = {}
    for gift = day, 2, -1 do lines[#lines + 1] = gifts[gift] end
    if day == 1 then
      lines[#lines + 1] = gifts[1]
    else
      lines[#lines + 1] = 'and ' .. gifts[1]
    end
    verses[#verses + 1] = 'On the ' .. ordinals[day] .. ' day of Christmas my true love gave to me: '
      .. table.concat(lines, ', ') .. '.'
  end
  return verses
end

return { recite = recite }
