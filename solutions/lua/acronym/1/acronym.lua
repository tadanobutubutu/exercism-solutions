return function(s)
  local letters = {}
  local phrase = s:gsub("'", '')
  for word in phrase:gmatch('[A-Za-z]+') do
    letters[#letters + 1] = word:sub(1, 1):upper()
  end
  return table.concat(letters)
end
