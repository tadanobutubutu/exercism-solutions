USING: accessors arrays kernel math math.functions sequences ;
IN: rational-numbers

! Define a `rat` tuple and the words below. `<rat>` should
! reduce its arguments to lowest terms with the sign on the
! numerator.

TUPLE: rat numerator denominator ;

:: <rat> ( numerator denominator -- rat )
    denominator 0 < [ numerator neg ] [ numerator ] if :> num
    denominator abs :> den
    num den gcd nip :> common
    num common /i den common /i rat boa ;

:: >rat ( pair -- rat ) pair first pair second <rat> ;

:: rat>pair ( value -- pair ) value numerator>> value denominator>> 2array ;

:: r+ ( a b -- c )
    a numerator>> b denominator>> * b numerator>> a denominator>> * +
    a denominator>> b denominator>> * <rat> ;
:: r- ( a b -- c )
    a numerator>> b denominator>> * b numerator>> a denominator>> * -
    a denominator>> b denominator>> * <rat> ;
:: r* ( a b -- c )
    a numerator>> b numerator>> * a denominator>> b denominator>> * <rat> ;
:: r/ ( a b -- c )
    a numerator>> b denominator>> * a denominator>> b numerator>> * <rat> ;

:: r-abs ( a -- |a| ) a numerator>> abs a denominator>> <rat> ;

! `r^` raises a `rat` to an integer power.
:: r^ ( a n -- a^n )
    n 0 = [ 1 1 <rat> ] [
        n abs :> power
        n 0 < [ a denominator>> power ^ a numerator>> power ^ <rat> ] [
            a numerator>> power ^ a denominator>> power ^ <rat>
        ] if
    ] if ;

! `real^r` raises a real to a `rat` exponent and returns a float.
:: real^r ( x a -- y ) x log a numerator>> a denominator>> / * e^ ;
