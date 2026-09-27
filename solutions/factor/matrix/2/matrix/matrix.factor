USING: kernel math math.parser sequences splitting ;
IN: matrix

: parse-row ( str -- row )
    " " split [ string>number ] map ;

: nth-row ( str n -- row )
    [ "\n" split ] dip 1 - swap nth parse-row ;

:: nth-column ( str n -- column )
    str "\n" split [ parse-row ] map :> rows
    n 1 - :> column-index
    rows [ column-index swap nth ] map ;
