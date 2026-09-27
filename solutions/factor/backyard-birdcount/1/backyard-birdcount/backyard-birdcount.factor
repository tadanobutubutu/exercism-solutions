USING: arrays kernel math math.order sequences ;
IN: backyard-birdcount

: today ( days -- count/f )
    dup empty? [ drop f ] [ first ] if ;

:: increment-day-count ( days -- new-days )
    days empty? [ { 1 } ] [ days first 1 + 1array days rest append ] if ;

:: has-day-without-birds? ( days -- ? )
    days empty? [ f ] [
        days first zero? [ t ] [ days rest has-day-without-birds? ] if
    ] if ;

:: total ( days -- sum )
    days empty? [ 0 ] [ days first days rest total + ] if ;

:: busy-days ( days -- count )
    days empty? [ 0 ] [
        days first 5 >=
        [ days rest busy-days 1 + ]
        [ days rest busy-days ] if
    ] if ;
