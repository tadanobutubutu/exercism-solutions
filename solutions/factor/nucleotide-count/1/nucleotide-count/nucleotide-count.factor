USING: assocs kernel sequences strings ;
IN: nucleotide-count

ERROR: invalid-nucleotide ;

:: nucleotide-counts ( strand -- counts )
    H{ { "A" 0 } { "C" 0 } { "G" 0 } { "T" 0 } } clone :> counts
    strand [| nucleotide |
        nucleotide 1string :> key
        key counts key? [ key counts inc-at ] [ invalid-nucleotide ] if
    ] each
    counts ;
