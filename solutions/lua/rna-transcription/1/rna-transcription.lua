return function(dna)
  local complements = { A = 'U', C = 'G', G = 'C', T = 'A' }
  local rna = {}
  for index = 1, #dna do
    local nucleotide = dna:sub(index, index)
    local complement = complements[nucleotide]
    if not complement then error('invalid nucleotide') end
    rna[index] = complement
  end
  return table.concat(rna)
end
