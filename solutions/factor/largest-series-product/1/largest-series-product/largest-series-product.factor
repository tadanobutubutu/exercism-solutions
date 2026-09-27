USING: ascii grouping kernel math math.order sequences ;
IN: largest-series-product

ERROR: invalid-input ;

:: largest-product ( digits span -- product )
    span 0 < [ invalid-input ] when
    digits [ digit? ] all? [ ] [ invalid-input ] if
    span digits length > [ invalid-input ] when
    span zero? [ 1 ] [
        digits [ CHAR: 0 - ] map span <clumps>
        [ product ] map 0 [ max ] reduce
    ] if ;
