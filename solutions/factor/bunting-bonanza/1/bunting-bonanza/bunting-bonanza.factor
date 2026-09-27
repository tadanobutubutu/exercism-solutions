USING: kernel math sequences strings ;
IN: bunting-bonanza

: alphabet-bunting ( n -- str )
    <iota> [ CHAR: a + ] map >string ;

: counting-bunting ( n -- str )
    <iota> [ 10 mod CHAR: 0 + ] map >string ;

: stripe-bunting ( n -- str )
    <iota> [ even? [ CHAR: * ] [ CHAR: - ] if ] map >string ;

: marker-bunting ( n -- str )
    <iota> [ 5 mod zero? [ CHAR: | ] [ CHAR: . ] if ] map >string ;

: valley-bunting ( -- str )
    10 <iota> [ 5 - abs CHAR: 0 + ] map >string ;
