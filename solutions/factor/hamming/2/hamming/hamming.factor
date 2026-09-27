USING: kernel locals math math.order sequences ;
IN: hamming

:: count-mismatches ( strand1 strand2 index total -- n )
    index strand1 length >=
    [ total ]
    [
        index strand1 nth index strand2 nth =
        [ total ] [ total 1 + ] if :> next-total
        strand1 strand2 index 1 + next-total count-mismatches
    ] if ;

:: distance ( strand1 strand2 -- n )
    strand1 length strand2 length =
    [ strand1 strand2 0 0 count-mismatches ]
    [ "strands must be of equal length" throw ]
    if ;
