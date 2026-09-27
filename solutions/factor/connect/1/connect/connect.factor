USING: arrays deques dlists hash-sets kernel math sequences sets ;
IN: connect

CONSTANT: hex-directions {
    { -1 0 } { -1 1 } { 0 -1 } { 0 1 } { 1 -1 } { 1 0 }
}

:: board-cells ( board -- cells )
    board [| line |
        line [| tile |
            tile CHAR: X = tile CHAR: O = or tile 46 = or
        ] filter >array
    ] map >array ;

:: connects? ( cells player -- ? )
    cells length :> height
    cells first length :> width
    HS{ } clone :> visited
    <dlist> :> frontier
    player CHAR: O = [ width ] [ height ] if <iota> [| i |
        player CHAR: O = [ 0 ] [ i ] if :> row
        player CHAR: O = [ i ] [ 0 ] if :> col
        row cells nth :> row-cells
        col row-cells nth player = [
            row width * col + visited adjoin
            row col 2array frontier push-back
        ] when
    ] each
    f :> won!
    [ frontier deque-empty? won or ] [
        frontier pop-front :> entry
        entry first :> row
        entry second :> col
        player CHAR: O = [ row height 1 - = ] [ col width 1 - = ] if [
            t won!
        ] [
            hex-directions [| direction |
                row direction first + :> next-row
                col direction second + :> next-col
                next-row 0 >= next-row height < and
                next-col 0 >= and next-col width < and [
                    next-row cells nth :> next-row-cells
                    next-col next-row-cells nth player = [
                        next-row width * next-col + :> position
                        position visited in? not [
                            position visited adjoin
                            next-row next-col 2array frontier push-back
                        ] when
                    ] when
                ] when
            ] each
        ] if
    ] until
    won ;

:: winner ( board -- str )
    board board-cells :> cells
    cells CHAR: O connects? [ "O" ] [
        cells CHAR: X connects? [ "X" ] [ "" ] if
    ] if ;
