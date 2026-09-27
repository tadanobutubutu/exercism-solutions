USING: arrays kernel math sequences vectors ;
IN: list-ops

:: list-append ( seq1 seq2 -- seq )
    V{ } clone :> result
    seq1 [ result push ] each
    seq2 [ result push ] each
    result >array ;

:: list-concat ( seqs -- seq )
    V{ } clone :> result
    seqs [| seq | seq [ result push ] each ] each
    result >array ;

:: list-length ( seq -- n )
    0 :> size!
    seq [ drop size 1 + size! ] each
    size ;

:: select ( seq quot -- seq' )
    V{ } clone :> result
    seq [| item | item quot call [ item result push ] when ] each
    result >array ; inline

:: collect ( seq quot -- seq' )
    V{ } clone :> result
    seq [| item | item quot call result push ] each
    result >array ; inline

:: foldl ( seq init quot -- result )
    init :> accumulator!
    seq [| item | accumulator item quot call accumulator! ] each
    accumulator ; inline

:: foldr ( seq init quot -- result )
    init :> accumulator!
    seq list-length :> size
    size <iota> [| offset |
        size offset - 1 - seq nth :> item
        accumulator item quot call accumulator!
    ] each
    accumulator ; inline

:: list-reverse ( seq -- seq' )
    V{ } clone :> result
    seq list-length :> size
    size <iota> [| offset |
        size offset - 1 - seq nth result push
    ] each
    result >array ;
