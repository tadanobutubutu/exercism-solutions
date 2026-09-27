USING: arrays kernel math math.functions math.parser math.statistics sequences ;
IN: armstrong-numbers

:: armstrong? ( n -- ? )
    n 0 < [ f ] [
        n number>string >array :> digits
        digits length :> count
        digits [ CHAR: 0 - ] map [ count ^ ] map sum n =
    ] if ;
