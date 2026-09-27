USING: kernel math ;
IN: collatz-conjecture

:: collatz-count ( n count -- steps )
    n 1 = [ count ] [
        n even? [ n 2 /i ] [ n 3 * 1 + ] if
        count 1 + collatz-count
    ] if ;

: steps ( n -- steps )
    dup 1 < [ drop "Only positive integers are allowed" throw ] [ 0 collatz-count ] if ;
