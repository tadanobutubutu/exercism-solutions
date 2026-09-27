local Anagram = {}

function Anagram:new(subject)
  return setmetatable({ subject = subject, normalized = subject:lower() }, self)
end

function Anagram:match(candidates)
  local sorted_subject = {}
  for character in self.normalized:gmatch('.') do sorted_subject[#sorted_subject + 1] = character end
  table.sort(sorted_subject)
  local signature = table.concat(sorted_subject)
  local matches = {}

  for _, candidate in ipairs(candidates) do
    local normalized = candidate:lower()
    if normalized ~= self.normalized and #normalized == #self.normalized then
      local letters = {}
      for character in normalized:gmatch('.') do letters[#letters + 1] = character end
      table.sort(letters)
      if table.concat(letters) == signature then matches[#matches + 1] = candidate end
    end
  end
  return matches
end

Anagram.__index = Anagram

return Anagram
