USING: kernel math math.parser sequences ;
IN: resistor-color-trio

: color>digit ( color -- digit )
    { "black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white" } index ;

:: label ( colors -- str )
    0 colors nth color>digit 10 *
    1 colors nth color>digit + :> significant
    2 colors nth color>digit :> exponent
    significant exponent { 1 10 100 1000 10000 100000 1000000 10000000 100000000 1000000000 } nth * :> ohms
    exponent significant 10 >= [ 1 + ] when 3 /i :> unit-index
    unit-index { 1 1000 1000000 1000000000 } nth :> scale
    ohms 10 * scale /i :> tenths
    tenths 10 /i number>string :> whole
    tenths 10 mod :> decimal
    decimal 0 = [ whole ] [ whole "." append decimal number>string append ] if
    unit-index { "ohms" "kiloohms" "megaohms" "gigaohms" } nth :> unit
    " " unit append append ;
