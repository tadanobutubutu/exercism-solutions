USING: kernel math sequences ;
IN: sum-of-multiples

:: sum-of-multiples ( factors limit -- sum )
    factors [ 0 > ] filter :> positive-factors
    limit <iota> [| n |
        positive-factors [| factor | n factor mod zero? ] any?
    ] filter sum ;
