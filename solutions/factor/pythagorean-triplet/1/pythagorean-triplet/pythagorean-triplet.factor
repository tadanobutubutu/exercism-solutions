USING: arrays kernel math math.order sequences vectors ;
IN: pythagorean-triplet

:: triplets-with-sum ( n -- triplets )
    V{ } clone :> triplets!
    n 3 /i 1 + <iota> [| offset |
        offset 1 + :> a
        n a 2 * - n * :> numerator
        2 n a - * :> denominator
        numerator denominator mod 0 = [
            numerator denominator /i :> b
            n a - b - :> c
            a b < b c < and b 0 > and [
                { a b c } triplets push
            ] when
        ] when
    ] each
    triplets >array ;
