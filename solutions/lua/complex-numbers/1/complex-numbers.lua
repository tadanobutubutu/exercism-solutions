local Complex
local mt = {}

local function as_complex(value)
  if getmetatable(value) == mt then return value end
  return Complex(value, 0)
end

Complex = function(real, imaginary)
  local value = { r = real or 0, i = imaginary or 0 }
  value.abs = function() return math.sqrt(value.r * value.r + value.i * value.i) end
  value.conj = function() return Complex(value.r, -value.i) end
  value.exp = function()
    local scale = math.exp(value.r)
    return Complex(scale * math.cos(value.i), scale * math.sin(value.i))
  end
  return setmetatable(value, mt)
end

mt.__add = function(left, right)
  left, right = as_complex(left), as_complex(right)
  return Complex(left.r + right.r, left.i + right.i)
end
mt.__sub = function(left, right)
  left, right = as_complex(left), as_complex(right)
  return Complex(left.r - right.r, left.i - right.i)
end
mt.__mul = function(left, right)
  left, right = as_complex(left), as_complex(right)
  return Complex(left.r * right.r - left.i * right.i, left.r * right.i + left.i * right.r)
end
mt.__div = function(left, right)
  left, right = as_complex(left), as_complex(right)
  local denominator = right.r * right.r + right.i * right.i
  return Complex((left.r * right.r + left.i * right.i) / denominator,
    (left.i * right.r - left.r * right.i) / denominator)
end
mt.__eq = function(left, right)
  return math.abs(left.r - right.r) < 1e-10 and math.abs(left.i - right.i) < 1e-10
end

return Complex
