USING: kernel math ;
IN: eliuds-eggs

: egg-count ( n -- count )
    dup 0 <= [ drop 0 ] [ dup 2 mod swap 2 /i egg-count + ] if ;
