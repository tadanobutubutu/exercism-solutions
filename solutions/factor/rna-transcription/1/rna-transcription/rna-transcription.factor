USING: kernel sequences strings ;
IN: rna-transcription

: to-rna ( dna -- rna )
    [
        dup CHAR: G = [ drop CHAR: C ] [
            dup CHAR: C = [ drop CHAR: G ] [
                dup CHAR: T = [ drop CHAR: A ] [ drop CHAR: U ] if
            ] if
        ] if
    ] map >string ;
