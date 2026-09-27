local function translate_word(word)
  if word:match('^[aeiou]') or word:match('^xr') or word:match('^yt') then
    return word .. 'ay'
  end

  local split = 1
  while split <= #word do
    local letter = word:sub(split, split)
    local is_vowel = letter:match('[aeiou]') ~= nil or (letter == 'y' and split > 1)
    if is_vowel then
      break
    end
    if letter == 'q' and word:sub(split + 1, split + 1) == 'u' then
      split = split + 2
    else
      split = split + 1
    end
  end
  return word:sub(split) .. word:sub(1, split - 1) .. 'ay'
end

return function(phrase)
  return (phrase:gsub('%S+', translate_word))
end
