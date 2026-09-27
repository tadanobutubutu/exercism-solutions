return function(s)
  local seen = {}
  for character in s:lower():gmatch('%a') do
    if seen[character] then return false end
    seen[character] = true
  end
  return true
end
