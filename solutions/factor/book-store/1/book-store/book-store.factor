USING: assocs kernel math math.bitwise namespaces sequences vectors ;
IN: book-store

SYMBOL: cost-cache

CONSTANT: prices-by-group-size { 0 800 1520 2160 2560 3000 }

:: in-stock-group? ( counts mask -- ? )
    5 <iota> [| book |
        mask book 2^ /i 2 mod 1 = [
            book counts nth 0 >
        ] [ t ] if
    ] all? ;

:: group-price ( mask -- cents )
    5 <iota> [| book | mask book 2^ /i 2 mod 1 = ] count
    prices-by-group-size nth ;

:: remove-group ( counts mask -- remaining )
    counts clone :> remaining
    5 <iota> [| book |
        mask book 2^ /i 2 mod 1 = [
            book remaining nth 1 - book remaining set-nth
        ] when
    ] each
    remaining ;

:: minimum-cost ( counts -- cents )
    counts cost-cache get at :> cached
    cached [ cached ] [
        counts [ zero? ] all? [ 0 ] [
            1000000 :> best!
            31 <iota> [| zero-mask |
                zero-mask 1 + :> mask
                counts mask in-stock-group? [
                    counts mask remove-group minimum-cost
                    mask group-price + :> candidate
                    candidate best < [ candidate best! ] when
                ] when
            ] each
            best
        ] if :> result
        result counts cost-cache get set-at
        result
    ] if ;

:: total ( basket -- cents )
    V{ 0 0 0 0 0 } clone :> counts
    basket [| book |
        book 1 - counts nth 1 + book 1 - counts set-nth
    ] each
    H{ } clone cost-cache set-global
    counts minimum-cost ;
