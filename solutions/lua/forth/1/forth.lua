local function copy_dictionary(dictionary)
  local result = {}
  for name, definition in pairs(dictionary) do result[name] = definition end
  return result
end

local function evaluate(instructions)
  local stack, dictionary, tokens = {}, {}, {}
  for _, line in ipairs(instructions) do
    for token in line:gmatch('%S+') do tokens[#tokens + 1] = token:lower() end
  end

  local function pop()
    if #stack == 0 then error('stack underflow') end
    return table.remove(stack)
  end

  local builtins = {}
  builtins['+'] = function()
    local right, left = pop(), pop()
    stack[#stack + 1] = left + right
  end
  builtins['-'] = function()
    local right, left = pop(), pop()
    stack[#stack + 1] = left - right
  end
  builtins['*'] = function()
    local right, left = pop(), pop()
    stack[#stack + 1] = left * right
  end
  builtins['/'] = function()
    local right, left = pop(), pop()
    if right == 0 then error('division by zero') end
    local quotient = left / right
    stack[#stack + 1] = math.modf(quotient)
  end
  builtins.dup = function()
    if #stack == 0 then error('stack underflow') end
    stack[#stack + 1] = stack[#stack]
  end
  builtins.drop = function() pop() end
  builtins.swap = function()
    local top, below = pop(), pop()
    stack[#stack + 1], stack[#stack + 2] = top, below
  end
  builtins.over = function()
    if #stack < 2 then error('stack underflow') end
    stack[#stack + 1] = stack[#stack - 1]
  end

  local execute_tokens
  execute_tokens = function(words, definitions, depth)
    if depth > 100 then error('definition recursion limit') end
    local i = 1
    while i <= #words do
      local word = words[i]
      if word == ':' then
        local name = words[i + 1]
        if not name or name == ';' or name:match('^-?%d+$') then error('invalid definition') end
        local body = {}
        i = i + 2
        while i <= #words and words[i] ~= ';' do
          body[#body + 1] = words[i]
          i = i + 1
        end
        if i > #words then error('unterminated definition') end
        definitions[name] = { body = body, dictionary = copy_dictionary(definitions) }
      elseif word == ';' then
        error('unexpected semicolon')
      elseif word:match('^-?%d+$') then
        stack[#stack + 1] = tonumber(word)
      elseif definitions[word] then
        local definition = definitions[word]
        execute_tokens(definition.body, definition.dictionary, depth + 1)
      elseif builtins[word] then
        builtins[word]()
      else
        error('unknown word')
      end
      i = i + 1
    end
  end

  execute_tokens(tokens, dictionary, 0)
  return stack
end

return { evaluate = evaluate }
