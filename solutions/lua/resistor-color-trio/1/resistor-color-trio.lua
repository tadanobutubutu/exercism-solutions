return {
  label = function(c1, c2, c3)
    local values = {
      black = 0, brown = 1, red = 2, orange = 3, yellow = 4,
      green = 5, blue = 6, violet = 7, grey = 8, white = 9,
    }
    local amount = (values[c1] * 10 + values[c2]) * 10 ^ values[c3]
    local units = { 'ohms', 'kiloohms', 'megaohms', 'gigaohms' }
    local unit = 1
    while amount >= 1000 and unit < #units do
      amount = amount / 1000
      unit = unit + 1
    end
    return amount, units[unit]
  end
}
