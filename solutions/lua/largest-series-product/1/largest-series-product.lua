return function(config)
  local digits, span = config.digits, config.span
  assert(type(digits) == 'string' and digits:match('^%d*$'), 'digits must contain only digits')
  assert(type(span) == 'number' and span >= 0, 'span must be non-negative')
  assert(span <= #digits, 'span cannot exceed the digits length')
  if span == 0 then return 1 end

  local best = 0
  for start = 1, #digits - span + 1 do
    local product = 1
    for index = start, start + span - 1 do
      product = product * tonumber(digits:sub(index, index))
    end
    if product > best then best = product end
  end
  return best
end
