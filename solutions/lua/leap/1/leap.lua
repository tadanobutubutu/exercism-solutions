local leap_year = function(number)
  return number % 400 == 0 or (number % 4 == 0 and number % 100 ~= 0)
end

return leap_year
