USING: ascii kernel sequences strings ;
IN: scrabble-score

: letter-score ( ch -- n )
    ch>lower
    dup "aeioulnrst" member? [ drop 1 ] [
        dup "dg" member? [ drop 2 ] [
            dup "bcmp" member? [ drop 3 ] [
                dup "fhvwy" member? [ drop 4 ] [
                    dup CHAR: k = [ drop 5 ] [
                        dup "jx" member? [ drop 8 ] [
                            dup "qz" member? [ drop 10 ] [ drop 0 ] if
                        ] if
                    ] if
                ] if
            ] if
        ] if
    ] if ;

: score ( word -- n )
    [ letter-score ] map sum ;
