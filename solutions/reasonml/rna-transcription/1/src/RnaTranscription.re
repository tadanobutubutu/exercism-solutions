type dna =
  | A
  | C
  | G
  | T;

type rna =
  | A
  | C
  | G
  | U;

let transcribeNucleotide = (nucleotide) =>
  switch (nucleotide) {
  | G => C
  | C => G
  | T => A
  | A => U
  };

let toRna = (strand) => List.map(transcribeNucleotide, strand);
