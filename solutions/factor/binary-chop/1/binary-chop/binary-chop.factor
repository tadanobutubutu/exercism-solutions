USING: kernel math sequences ;
IN: binary-chop

ERROR: value-not-in-array ;

:: find ( array value -- index )
    0 :> low!
    array length 1 - :> high!
    f :> found!
    [ low high <= found not and ] [
        low high + 2 /i :> middle
        middle array nth :> current
        current value = [
            middle found!
        ] [
            current value < [ middle 1 + low! ] [ middle 1 - high! ] if
        ] if
    ] while
    found [ found ] [ value-not-in-array ] if ;
