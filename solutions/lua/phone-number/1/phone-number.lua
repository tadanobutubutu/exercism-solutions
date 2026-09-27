local function clean(s)
  if s:find('[^%d%+%-%s%(%)%.]') then error('invalid phone number') end
  local digits = s:gsub('%D', '')
  if #digits == 11 and digits:sub(1, 1) == '1' then
    digits = digits:sub(2)
  end
  if #digits ~= 10 or digits:sub(1, 1):match('[01]') or digits:sub(4, 4):match('[01]') then
    error('invalid phone number')
  end
  return digits
end

return { clean = clean }
