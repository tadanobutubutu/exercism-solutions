USING: arrays kernel math math.functions math.order math.parser ranges sequences strings vectors ;
IN: palindrome-products

:: palindrome-from-prefix ( prefix digits -- value )
    prefix number>string :> text
    digits 2 mod zero? [
        text reverse
    ] [
        0 text length 1 - text subseq reverse
    ] if
    text swap append string>number ;

:: prefixes-for-digits ( mn mx digits -- prefixes )
    mn mn * :> min-product
    mx mx * :> max-product
    10 digits 1 - ^ min-product max :> lower
    10 digits ^ 1 - max-product min :> upper
    lower upper > [ { } ] [
        digits 1 + 2 /i :> prefix-length
        lower number>string :> lower-text
        upper number>string :> upper-text
        0 prefix-length lower-text subseq string>number :> first-prefix
        0 prefix-length upper-text subseq string>number :> last-prefix
        first-prefix last-prefix [a..b]
    ] if ;

:: factors-for ( value mn mx -- factors )
    value mx /i :> quotient
    value mx mod zero? [ quotient ] [ quotient 1 + ] if mn max :> first-factor
    value sqrt floor >integer mx min :> last-factor
    V{ } clone :> factors
    first-factor last-factor <= [
        first-factor last-factor [a..b] [| factor |
            value factor mod zero? [
                value factor /i :> other
                other mn >= other mx <= and [
                    factor other 2array factors push
                ] when
            ] when
        ] each
    ] when
    factors >array ;

:: find-extreme ( mn mx largest? -- value/f factors )
    mn mn * number>string length :> min-digits
    mx mx * number>string length :> max-digits
    min-digits max-digits [a..b] :> digit-counts
    largest? [ digit-counts reverse ] [ digit-counts ] if :> ordered-digits
    f :> result!
    { } :> result-factors!
    ordered-digits [| digits |
        mn mx digits prefixes-for-digits :> prefixes
        largest? [ prefixes reverse ] [ prefixes ] if :> ordered-prefixes
        ordered-prefixes [| prefix |
            result f = [
                prefix digits palindrome-from-prefix :> candidate
                candidate mn mx factors-for :> factors
                factors empty? not [
                    candidate result!
                    factors result-factors!
                ] when
            ] when
        ] each
    ] each
    result result-factors ;

:: smallest ( mn mx -- value factors )
    mn mx > [ "min must be <= max" throw ] when
    mn mx f find-extreme ;

:: largest ( mn mx -- value factors )
    mn mx > [ "min must be <= max" throw ] when
    mn mx t find-extreme ;
