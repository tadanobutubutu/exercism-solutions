USING: arrays kernel sequences ;
IN: flatten-array

:: flatten ( array -- flat )
    array [
        dup f = [ drop { } ] [
            dup array? [ flatten ] [ 1array ] if
        ] if
    ] map concat ;
