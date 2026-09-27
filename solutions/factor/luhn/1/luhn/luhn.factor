USING: kernel math math.statistics sequences unicode ;
IN: luhn

:: ascii-digit? ( ch -- ? )
    ch CHAR: 0 >= ch CHAR: 9 <= and ;

:: luhn-value ( ch position -- n )
    ch CHAR: 0 - :> digit
    position 2 mod 1 = [
        digit 2 * dup 9 > [ 9 - ] when
    ] [ digit ] if ;

:: valid? ( value -- ? )
    value [ dup ascii-digit? swap CHAR: \s = or ] all? [
        value [ ascii-digit? ] filter :> digits
        digits length 2 >= [
            digits reverse [| ch position | ch position luhn-value ] map-index
            sum 10 mod zero?
        ] [ f ] if
    ] [ f ] if ;
