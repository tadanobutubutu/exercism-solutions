USING: kernel math ;
IN: square-root

:: newton-root ( n guess -- root )
    n guess /i guess + 2 /i :> next
    next guess >= [ guess ] [ n next newton-root ] if ;

: square-root ( n -- root )
    dup 0 = [ drop 0 ] [ dup newton-root ] if ;
