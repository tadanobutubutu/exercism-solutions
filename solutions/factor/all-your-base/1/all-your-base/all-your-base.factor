USING: arrays kernel math math.order sequences vectors ;
IN: all-your-base

:: rebase ( digits input-base output-base -- digits' )
    input-base 2 < [ "input base must be >= 2" throw ] when
    digits [| digit |
        digit 0 < digit input-base >= or [
            "all digits must satisfy 0 <= d < input base" throw
        ] when
    ] each
    output-base 2 < [ "output base must be >= 2" throw ] when
    0 :> value!
    digits [| digit | value input-base * digit + value! ] each
    value 0 = [ { 0 } ] [
        V{ } clone :> result!
        [ value 0 > ] [
            value output-base mod result push
            value output-base /i value!
        ] while
        result reverse >array
    ] if ;
