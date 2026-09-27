local BottleSong = {}

function BottleSong.recite(start_bottles, take_down)
  local names = { 'no', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten' }
  local verses = {}
  for count = start_bottles, start_bottles - take_down + 1, -1 do
    local current = names[count + 1]
    local following = names[count]
    local current_plural = count == 1 and '' or 's'
    local next_plural = count == 2 and '' or 's'
    local capitalized = current:sub(1, 1):upper() .. current:sub(2)
    verses[#verses + 1] = table.concat({
      capitalized .. ' green bottle' .. current_plural .. ' hanging on the wall,\n',
      capitalized .. ' green bottle' .. current_plural .. ' hanging on the wall,\n',
      'And if one green bottle should accidentally fall,\n',
      "There'll be " .. following .. ' green bottle' .. next_plural .. ' hanging on the wall.\n'
    })
  end
  return table.concat(verses, '\n')
end

return BottleSong
