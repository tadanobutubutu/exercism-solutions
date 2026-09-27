local function count_words(s)
  local result = {}
  for token in s:lower():gmatch("[%w']+") do
    local word = token:gsub("^'+", ''):gsub("'+$", '')
    if word ~= '' then result[word] = (result[word] or 0) + 1 end
  end
  return result
end

return { count_words = count_words }
