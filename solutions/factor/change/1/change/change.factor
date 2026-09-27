USING: assocs kernel math sequences sets sorting ;
IN: change

ERROR: cannot-make-change ;

:: find-fewest-coins ( coins target -- result )
    target 0 < [ cannot-make-change ] when
    H{ { 0 { } } } clone :> best-by-value
    target <iota> [| zero |
        zero 1 + :> amount
        f :> best!
        coins members natural-sort [| coin |
            amount coin >= [
                amount coin - best-by-value at :> prefix
                prefix [
                    prefix { coin } append :> candidate
                    best [ candidate length best length < ] [ t ] if
                        [ candidate best! ] when
                ] when
            ] when
        ] each
        best [ best amount best-by-value set-at ] when
    ] each
    target best-by-value at :> result
    result [ result natural-sort ] [ cannot-make-change ] if ;
