USING: accessors arrays kernel math math.constants math.functions sequences ;
IN: complex-numbers

! Define a `cmplx` tuple with `real` and `imaginary` slots and
! the words below. The accessors `real>>` and `imaginary>>` come
! for free with the tuple definition.

TUPLE: cmplx real imaginary ;

: <cmplx> ( real imag -- cmplx ) cmplx boa ;
: >cmplx ( pair -- cmplx )
    [ first ] [ second ] bi <cmplx> ;
: cmplx>pair ( cmplx -- pair )
    [ real>> ] [ imaginary>> ] bi 2array ;

:: c+ ( a b -- c )
    a real>> b real>> + a imaginary>> b imaginary>> + <cmplx> ;
:: c- ( a b -- c )
    a real>> b real>> - a imaginary>> b imaginary>> - <cmplx> ;
:: c* ( a b -- c )
    a real>> b real>> * a imaginary>> b imaginary>> * -
    a real>> b imaginary>> * a imaginary>> b real>> * + <cmplx> ;
:: c/ ( a b -- c )
    b real>> :> br
    b imaginary>> :> bi
    br br * bi bi * + :> divisor
    a real>> br * a imaginary>> bi * + divisor /
    a imaginary>> br * a real>> bi * - divisor / <cmplx> ;

:: c-abs ( a -- |a| ) a real>> dup * a imaginary>> dup * + sqrt ;
:: c-conj ( a -- a* ) a real>> a imaginary>> neg <cmplx> ;
:: c-exp ( z -- e^z )
    z real>> e^ :> scale
    z imaginary>> cos scale *
    z imaginary>> sin scale * <cmplx> ;
