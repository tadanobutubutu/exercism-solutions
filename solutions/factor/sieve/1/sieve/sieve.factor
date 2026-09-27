USING: kernel math math.primes sequences vectors ;
IN: sieve

:: primes ( limit -- result )
    V{ } clone :> result
    limit 1 + <iota> [| candidate |
        candidate 2 >= candidate prime? and [ candidate result push ] when
    ] each
    result ;
