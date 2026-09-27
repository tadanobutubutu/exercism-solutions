USING: kernel math.parser sequences splitting ;
IN: matrix

: parse-row ( str -- row )
    " " split [ string>number ] map ;

: nth-row ( str n -- row )
    [ "\n" split ] dip 1 - nth parse-row ;

: nth-column ( str n -- column )
    [ "\n" split [ parse-row ] map ] dip 1 - [ nth ] curry map ;
