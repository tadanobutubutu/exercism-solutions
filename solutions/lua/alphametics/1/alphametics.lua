local precedence = { ['+'] = 1, ['-'] = 1, ['*'] = 2, ['/'] = 2, ['%'] = 2, ['^'] = 3 }

local function to_rpn(expression)
  local output, operators = {}, {}
  local tokens = {}
  local i = 1
  while i <= #expression do
    local char = expression:sub(i, i)
    if char:match('%s') then
      i = i + 1
    elseif char:match('%u') then
      local word = expression:match('^%u+', i)
      tokens[#tokens + 1] = word
      i = i + #word
    elseif char:match('%d') then
      local number = expression:match('^%d+', i)
      tokens[#tokens + 1] = number
      i = i + #number
    else
      tokens[#tokens + 1] = char
      i = i + 1
    end
  end

  for _, token in ipairs(tokens) do
    if token:match('^%u+$') or token:match('^%d+$') then
      output[#output + 1] = token
    elseif token == '(' then
      operators[#operators + 1] = token
    elseif token == ')' then
      while #operators > 0 and operators[#operators] ~= '(' do
        output[#output + 1] = table.remove(operators)
      end
      table.remove(operators)
    else
      while #operators > 0 and precedence[operators[#operators]]
        and (precedence[operators[#operators]] > precedence[token]
          or (precedence[operators[#operators]] == precedence[token] and token ~= '^')) do
        output[#output + 1] = table.remove(operators)
      end
      operators[#operators + 1] = token
    end
  end
  while #operators > 0 do output[#output + 1] = table.remove(operators) end
  return output
end

local function evaluate(rpn, mapping, stack)
  local top = 0
  for _, token in ipairs(rpn) do
    if precedence[token] then
      local right, left = stack[top], stack[top - 1]
      top = top - 2
      if token == '+' then top = top + 1; stack[top] = left + right
      elseif token == '-' then top = top + 1; stack[top] = left - right
      elseif token == '*' then top = top + 1; stack[top] = left * right
      elseif token == '/' then top = top + 1; stack[top] = left / right
      elseif token == '%' then top = top + 1; stack[top] = left % right
      elseif token == '^' then top = top + 1; stack[top] = left ^ right end
    elseif token:match('^%d+$') then
      top = top + 1
      stack[top] = tonumber(token)
    else
      local value = 0
      for i = 1, #token do value = value * 10 + mapping[token:sub(i, i)] end
      top = top + 1
      stack[top] = value
    end
  end
  return stack[top]
end

local function solve(puzzle)
  local left, right = puzzle:match('^(.-)%s*==%s*(.-)$')
  if not left then error('invalid puzzle') end
  local letters, seen, leading = {}, {}, {}
  for word in puzzle:gmatch('%u+') do
    if #word > 1 then leading[word:sub(1, 1)] = true end
    for i = 1, #word do
      local letter = word:sub(i, i)
      if not seen[letter] then
        seen[letter] = true
        letters[#letters + 1] = letter
      end
    end
  end
  if #letters > 10 then return nil end

  local lhs, rhs = to_rpn(left), to_rpn(right)
  local mapping, used, lhs_stack, rhs_stack = {}, {}, {}, {}
  local answer

  local function search(index)
    if index > #letters then
      if evaluate(lhs, mapping, lhs_stack) == evaluate(rhs, mapping, rhs_stack) then
        answer = {}
        for letter, digit in pairs(mapping) do answer[letter] = digit end
        return true
      end
      return false
    end
    local letter = letters[index]
    local minimum = leading[letter] and 1 or 0
    for digit = minimum, 9 do
      if not used[digit] then
        mapping[letter], used[digit] = digit, true
        if search(index + 1) then return true end
        mapping[letter], used[digit] = nil, nil
      end
    end
    return false
  end

  search(1)
  return answer
end

return { solve = solve }
