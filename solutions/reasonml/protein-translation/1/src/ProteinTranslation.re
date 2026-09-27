let isStop = (codon) => codon == "UAA" || codon == "UAG" || codon == "UGA";

let translateCodon = (codon) =>
  switch (codon) {
  | "AUG" => "Methionine"
  | "UUU" | "UUC" => "Phenylalanine"
  | "UUA" | "UUG" => "Leucine"
  | "UCU" | "UCC" | "UCA" | "UCG" => "Serine"
  | "UAU" | "UAC" => "Tyrosine"
  | "UGU" | "UGC" => "Cysteine"
  | "UGG" => "Tryptophan"
  | _ => ""
  };

let rec translate = (rna, index, result) =>
  if (index + 3 > String.length(rna)) {
    List.rev(result);
  } else {
    let codon = String.sub(rna, index, 3);
    if (isStop(codon)) {
      List.rev(result);
    } else {
      let protein = translateCodon(codon);
      if (String.length(protein) == 0) {
        List.rev(result);
      } else {
        translate(rna, index + 3, [protein, ...result]);
      };
    };
  };

let proteins = (rna) => translate(rna, 0, []);
