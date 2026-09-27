return {
  color_code = function(color)
    local colors = {
      'black', 'brown', 'red', 'orange', 'yellow',
      'green', 'blue', 'violet', 'grey', 'white',
    }
    for code, name in ipairs(colors) do
      if name == color then return code - 1 end
    end
    error('unknown color')
  end,
  colors = function()
    return {
      'black', 'brown', 'red', 'orange', 'yellow',
      'green', 'blue', 'violet', 'grey', 'white',
    }
  end
}
