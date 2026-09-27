USING: kernel math typed ;
IN: nth-prime

:: prime? ( n -- ? )
    n 2 < [ f ] [
        2 :> divisor!
        f :> composite!
        [ divisor divisor * n <= composite not and ] [
            n divisor mod zero? [ t composite! ] [ divisor 1 + divisor! ] if
        ] while
        composite not
    ] if ;

TYPED:: nth-prime ( n: integer -- prime: integer )
    n 0 <= [ "there is no zeroth prime" throw ] when
    1 :> candidate!
    0 :> count!
    [ count n < ] [
        candidate 1 + candidate!
        candidate prime? [ count 1 + count! ] when
    ] while
    candidate ;
