USING: ascii grouping kernel math math.functions math.order sequences strings ;
IN: affine-cipher

ERROR: invalid-key ;

:: validate-key ( a -- )
    a 26 gcd nip 1 = [ ] [ "a and m must be coprime." throw ] if ;

:: normalized-characters ( phrase -- chars )
    phrase >lower [ dup letter? swap digit? or ] filter ;

:: encode ( phrase a b -- cipher )
    a validate-key
    phrase normalized-characters [| ch |
        ch digit? [ ch ] [ ch CHAR: a - a * b + 26 mod CHAR: a + ] if
    ] map 5 group [ >string ] map " " join ;

:: decode ( cipher a b -- plain )
    a validate-key
    1 :> inverse!
    [ a inverse * 26 mod 1 = not ] [ inverse 1 + inverse! ] while
    cipher normalized-characters [| ch |
        ch digit? [ ch ] [ ch CHAR: a - b - inverse * 26 mod 26 + 26 mod CHAR: a + ] if
    ] map >string ;
