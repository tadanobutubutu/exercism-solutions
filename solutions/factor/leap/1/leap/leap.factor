USING: kernel math math.order ;
IN: leap

: leap-year? ( year -- ? )
    dup 400 mod 0 =
    [ drop t ]
    [ dup 4 mod 0 = swap 100 mod 0 = not and ]
    if ;
