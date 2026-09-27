USING: kernel math sequences strings ;
IN: roman-numerals

CONSTANT: roman-values {
    { 1000 "M" } { 900 "CM" } { 500 "D" } { 400 "CD" }
    { 100 "C" } { 90 "XC" } { 50 "L" } { 40 "XL" }
    { 10 "X" } { 9 "IX" } { 5 "V" } { 4 "IV" } { 1 "I" }
}

:: roman ( n -- result )
    "" :> result!
    n :> remaining!
    roman-values [| entry |
        entry first :> value
        entry second :> symbol
        [ remaining value >= ] [
            result symbol append result!
            remaining value - remaining!
        ] while
    ] each
    result ;
