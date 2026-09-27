return function(s, length)
  if s == '' then error('series cannot be empty') end
  if length < 0 then error('slice length cannot be negative') end
  if length == 0 then error('slice length cannot be zero') end
  if length > #s then error('slice length cannot be greater than series length') end
  local position = 1
  return function()
    if position + length - 1 > #s then return nil end
    local slice = s:sub(position, position + length - 1)
    position = position + 1
    return slice
  end
end
