local function list(score)
  local allergens = { 'eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats' }
  local result = {}
  for index, allergen in ipairs(allergens) do
    if math.floor(score / (2 ^ (index - 1))) % 2 == 1 then
      result[#result + 1] = allergen
    end
  end
  return result
end

local function allergic_to(score, which)
  local allergens = { 'eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats' }
  for index, allergen in ipairs(allergens) do
    if allergen == which then
      return math.floor(score / (2 ^ (index - 1))) % 2 == 1
    end
  end
  return false
end

return { list = list, allergic_to = allergic_to }
