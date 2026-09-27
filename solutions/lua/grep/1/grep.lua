return function(options)
  local flag = {}
  for _, value in ipairs(options.flags or {}) do flag[value] = true end
  local result = {}
  local multiple_files = #(options.files or {}) > 1
  local search_pattern = flag['-i'] and options.pattern:lower() or options.pattern

  for _, filename in ipairs(options.files or {}) do
    local file = assert(io.open(filename, 'r'))
    local matches = {}
    local line_number = 0
    for line in file:lines() do
      line_number = line_number + 1
      local candidate = flag['-i'] and line:lower() or line
      local matched = flag['-x'] and candidate == search_pattern
        or not flag['-x'] and candidate:find(search_pattern, 1, true) ~= nil
      if flag['-v'] then matched = not matched end
      if matched then matches[#matches + 1] = { number = line_number, text = line } end
    end
    file:close()

    if flag['-l'] then
      if #matches > 0 then result[#result + 1] = filename end
    else
      for _, match in ipairs(matches) do
        local prefix = multiple_files and (filename .. ':') or ''
        if flag['-n'] then prefix = prefix .. match.number .. ':' end
        result[#result + 1] = prefix .. match.text
      end
    end
  end
  return result
end
