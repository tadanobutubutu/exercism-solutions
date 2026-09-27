return function(s)
  local letters = {}
  for letter in s:lower():gmatch('[a-z]') do
    letters[letter] = true
  end
  for code = string.byte('a'), string.byte('z') do
    if not letters[string.char(code)] then return false end
  end
  return true
end
