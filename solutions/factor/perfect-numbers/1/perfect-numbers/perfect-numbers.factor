USING: kernel math math.order math.primes.factors sequences ;
IN: perfect-numbers

:: classify ( n -- str )
    n 0 <= [ "Classification is only possible for positive integers." throw ] when
    n divisors sum n - :> aliquot-sum
    aliquot-sum n = [ "perfect" ] [
        aliquot-sum n > [ "abundant" ] [ "deficient" ] if
    ] if ;
