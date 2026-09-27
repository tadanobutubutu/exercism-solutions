USING: ascii kernel math math.parser sequences strings ;
IN: run-length-encoding

:: encode ( str -- encoded )
    "" :> encoded!
    0 :> index!
    str length :> size
    [ index size < ] [
        index str nth :> ch
        1 :> count!
        [ index count + size < [ index count + str nth ch = ] [ f ] if ] [
            count 1 + count!
        ] while
        count 1 > [ encoded count number>string append encoded! ] when
        encoded ch 1string append encoded!
        index count + index!
    ] while
    encoded ;

:: decode ( encoded -- decoded )
    "" :> decoded!
    0 :> count!
    encoded [| ch |
        ch digit? [
            count 10 * ch CHAR: 0 - + count!
        ] [
            count 0 = [ 1 ] [ count ] if :> repeats
            repeats [ ch ] replicate >string :> piece
            decoded piece append decoded!
            0 count!
        ] if
    ] each
    decoded ;
