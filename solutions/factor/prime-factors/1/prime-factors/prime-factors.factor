USING: arrays kernel math sequences vectors ;
IN: prime-factors

:: factors ( n -- factors )
    n :> remaining!
    2 :> divisor!
    V{ } clone :> result
    [ remaining 1 > ] [
        divisor divisor * remaining > [
            remaining result push
            1 remaining!
        ] [
            remaining divisor mod zero? [
                divisor result push
                remaining divisor /i remaining!
            ] [
                divisor 1 + divisor!
            ] if
        ] if
    ] while
    result >array ;
