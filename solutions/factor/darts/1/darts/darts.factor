USING: kernel math math.order ;
IN: darts

: score ( x y -- n )
    dup * swap dup * +
    dup 1 <= [ drop 10 ]
    [ dup 25 <= [ drop 5 ] [ dup 100 <= [ drop 1 ] [ drop 0 ] if ] if ]
    if ;
