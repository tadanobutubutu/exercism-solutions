local function answer(question)
  local expression = question:match('^What is (.-)%?$')
  if not expression or question:sub(-1) ~= '?' then error('Invalid question') end
  local first, remainder = expression:match('^%s*(-?%d+)(.*)$')
  if not first then error('Invalid question') end
  local value = tonumber(first)

  while remainder ~= '' do
    remainder = remainder:gsub('^%s+', '')
    local operation
    if remainder:match('^plus%s+') then operation = 'plus'; remainder = remainder:gsub('^plus%s+', '', 1)
    elseif remainder:match('^minus%s+') then operation = 'minus'; remainder = remainder:gsub('^minus%s+', '', 1)
    elseif remainder:match('^multiplied by%s+') then operation = 'multiplied'; remainder = remainder:gsub('^multiplied by%s+', '', 1)
    elseif remainder:match('^divided by%s+') then operation = 'divided'; remainder = remainder:gsub('^divided by%s+', '', 1)
    else error('Invalid question') end

    local operand
    operand, remainder = remainder:match('^%s*(-?%d+)(.*)$')
    if not operand then error('Invalid question') end
    operand = tonumber(operand)
    if operation == 'plus' then value = value + operand
    elseif operation == 'minus' then value = value - operand
    elseif operation == 'multiplied' then value = value * operand
    else value = value / operand end
  end
  return value
end

return { answer = answer }
