return function(l1, l2)
  local function is_sublist(shorter, longer)
    if #shorter > #longer then return false end
    for start = 1, #longer - #shorter + 1 do
      local matches = true
      for offset = 1, #shorter do
        if shorter[offset] ~= longer[start + offset - 1] then
          matches = false
          break
        end
      end
      if matches then return true end
    end
    return false
  end

  if #l1 == #l2 then
    if is_sublist(l1, l2) then return 'equal' end
    return 'unequal'
  end
  if #l1 < #l2 then return is_sublist(l1, l2) and 'sublist' or 'unequal' end
  return is_sublist(l2, l1) and 'superlist' or 'unequal'
end
