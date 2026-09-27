return {
  valid = function(s)
    if s:find('[^%d ]') then return false end
    local digits = s:gsub(' ', '')
    if #digits < 2 then return false end
    local sum = 0
    local double = false
    for index = #digits, 1, -1 do
      local digit = tonumber(digits:sub(index, index))
      if double then
        digit = digit * 2
        if digit > 9 then digit = digit - 9 end
      end
      sum = sum + digit
      double = not double
    end
    return sum % 10 == 0
  end
}
