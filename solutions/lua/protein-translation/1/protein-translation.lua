local function proteins(strand)
  local translations = {
    AUG = 'Methionine',
    UUU = 'Phenylalanine', UUC = 'Phenylalanine',
    UUA = 'Leucine', UUG = 'Leucine',
    UCU = 'Serine', UCC = 'Serine', UCA = 'Serine', UCG = 'Serine',
    UAU = 'Tyrosine', UAC = 'Tyrosine',
    UGU = 'Cysteine', UGC = 'Cysteine',
    UGG = 'Tryptophan',
    UAA = false, UAG = false, UGA = false,
  }
  local result = {}
  for index = 1, #strand - 2, 3 do
    local codon = strand:sub(index, index + 2)
    local protein = translations[codon]
    if protein == false then break end
    if protein == nil then error('Invalid codon') end
    result[#result + 1] = protein
  end
  return result
end

return { proteins = proteins }
