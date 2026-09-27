return {
  valid = function(s)
    local closing_for = { [')'] = '(', [']'] = '[', ['}'] = '{' }
    local openings = { ['('] = true, ['['] = true, ['{'] = true }
    local stack = {}
    for char in s:gmatch('[%(%)%[%]{}]') do
      if openings[char] then
        stack[#stack + 1] = char
      elseif stack[#stack] ~= closing_for[char] then
        return false
      else
        stack[#stack] = nil
      end
    end
    return #stack == 0
  end
}
