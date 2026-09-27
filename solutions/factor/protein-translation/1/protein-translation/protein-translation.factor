USING: arrays assocs kernel math sequences vectors ;
IN: protein-translation

ERROR: invalid-codon ;

CONSTANT: amino-acids H{
    { "AUG" "Methionine" }
    { "UUU" "Phenylalanine" }
    { "UUC" "Phenylalanine" }
    { "UUA" "Leucine" }
    { "UUG" "Leucine" }
    { "UCU" "Serine" }
    { "UCC" "Serine" }
    { "UCA" "Serine" }
    { "UCG" "Serine" }
    { "UAU" "Tyrosine" }
    { "UAC" "Tyrosine" }
    { "UGU" "Cysteine" }
    { "UGC" "Cysteine" }
    { "UGG" "Tryptophan" }
}

CONSTANT: stop-codons { "UAA" "UAG" "UGA" }

:: proteins ( strand -- result )
    V{ } clone :> result
    0 :> index!
    f :> stopped!
    [ stopped not index strand length < and ] [
        index 3 + strand length > [ invalid-codon ] when
        index index 3 + strand subseq :> codon
        codon stop-codons member? [
            t stopped!
        ] [
            codon amino-acids at dup [ result push ] [ drop invalid-codon ] if
            index 3 + index!
        ] if
    ] while
    result >array ;
