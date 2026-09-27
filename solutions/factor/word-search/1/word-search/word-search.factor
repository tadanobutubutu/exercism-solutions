USING: arrays assocs kernel math sequences ;
IN: word-search

:: matches-at? ( grid word start-x start-y dx dy -- ? )
    word length <iota> [| offset |
        start-x offset dx * + :> x
        start-y offset dy * + :> y
        x 1 >= y 1 >= and
        x grid first length <= and
        y grid length <= and
        [ y 1 - grid nth x 1 - swap nth offset word nth = ] [ f ] if
    ] all? ;

:: check-direction ( grid word column row direction matches -- )
    direction 3 mod 1 - :> dx
    direction 3 /i 1 - :> dy
    grid word column 1 + row 1 + dx dy matches-at? [
        column 1 + row 1 + 2array :> start
        column word length 1 - dx * + 1 + :> end-x
        row word length 1 - dy * + 1 + :> end-y
        end-x end-y 2array :> end
        start end 2array matches push
    ] when ;

:: locate-word ( grid word -- location/f )
    grid first length :> width
    grid length :> height
    V{ } clone :> matches
    height <iota> [| row |
        width <iota> [| column |
            9 <iota> [| direction |
                direction 4 = not [
                    grid word column row direction matches check-direction
                ] when
            ] each
        ] each
    ] each
    matches empty? [ f ] [ matches first ] if ;

:: search ( grid words -- results )
    H{ } clone :> results
    words [| word |
        grid word locate-word word results set-at
    ] each
    results ;
