USING: kernel math.functions math.order ;
IN: grains

: square ( n -- grains )
    dup 1 < over 64 > or
    [ drop "square must be between 1 and 64" throw ]
    [ 2 swap 1 - ^ ] if ;

: total ( -- grains )
    2 64 ^ 1 - ;
