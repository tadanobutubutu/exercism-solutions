USING: arrays kernel math sequences sorting ;
IN: killer-sudoku-helper

:: choose-combinations ( digits total size -- combinations )
    size 0 = [
        total 0 = [ { { } } ] [ { } ] if
    ] [
        digits empty? [ { } ] [
            digits first :> digit
            digits rest :> remaining
            remaining total size choose-combinations :> without-digit
            remaining total digit - size 1 - choose-combinations
                [| suffix | digit 1array suffix append ] map :> with-digit
            without-digit with-digit append
        ] if
    ] if ;

:: combinations ( total size excluded -- results )
    { 1 2 3 4 5 6 7 8 9 }
    [| digit | digit excluded member? not ] filter
    total size choose-combinations sort ;
