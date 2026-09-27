USING: kernel math math.bitwise math.intervals math.order sequences ;
IN: game-of-life

:: live-cell? ( matrix row col -- ? )
    row matrix nth 1 col shift bitand 0 = not ;

:: neighbor-count ( matrix cols row col -- count )
    0 :> count!
    { -1 0 1 } [| row-offset |
        { -1 0 1 } [| col-offset |
            row-offset 0 = col-offset 0 = and not [
                row row-offset + :> neighbor-row
                col col-offset + :> neighbor-col
                neighbor-row 0 >= neighbor-row matrix length < and [
                    neighbor-col 0 >= neighbor-col cols < and [
                        matrix neighbor-row neighbor-col live-cell?
                        [ count 1 + count! ] when
                    ] when
                ] when
            ] when
        ] each
    ] each
    count ;

:: next-row ( matrix cols row -- row-mask )
    0 :> result!
    cols <iota> [| col |
        matrix cols row col neighbor-count :> neighbors
        matrix row col live-cell? :> alive
        neighbors 3 = alive neighbors 2 = and or :> survives
        alive not neighbors 3 = and survives or [
            result col set-bit result!
        ] when
    ] each
    result ;

:: tick ( matrix cols -- matrix' )
    matrix [| row-mask row | matrix cols row next-row ] map-index ;
