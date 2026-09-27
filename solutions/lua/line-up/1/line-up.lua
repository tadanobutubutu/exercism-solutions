return {
  format = function(name, number)
    local last_two = number % 100
    local last = number % 10
    local suffix = 'th'
    if last_two < 11 or last_two > 13 then
      if last == 1 then suffix = 'st'
      elseif last == 2 then suffix = 'nd'
      elseif last == 3 then suffix = 'rd' end
    end
    return string.format('%s, you are the %d%s customer we serve today. Thank you!', name, number, suffix)
  end
}
