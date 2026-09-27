return {
  to_roman = function(n)
    local values = {
      { 1000, 'M' }, { 900, 'CM' }, { 500, 'D' }, { 400, 'CD' },
      { 100, 'C' }, { 90, 'XC' }, { 50, 'L' }, { 40, 'XL' },
      { 10, 'X' }, { 9, 'IX' }, { 5, 'V' }, { 4, 'IV' }, { 1, 'I' }
    }
    local result = {}
    for _, pair in ipairs(values) do
      while n >= pair[1] do
        result[#result + 1] = pair[2]
        n = n - pair[1]
      end
    end
    return table.concat(result)
  end
}
