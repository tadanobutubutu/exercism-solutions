local DNA = {}

function DNA:new(sequence)
  local counts = { A = 0, C = 0, G = 0, T = 0 }
  for nucleotide in sequence:gmatch('.') do
    if counts[nucleotide] == nil then error('Invalid Sequence') end
    counts[nucleotide] = counts[nucleotide] + 1
  end
  return setmetatable({ nucleotideCounts = counts }, self)
end

function DNA:count(nucleotide)
  if self.nucleotideCounts[nucleotide] == nil then error('Invalid Nucleotide') end
  return self.nucleotideCounts[nucleotide]
end

DNA.__index = DNA

return DNA
