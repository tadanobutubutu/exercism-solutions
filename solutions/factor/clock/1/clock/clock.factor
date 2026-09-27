USING: kernel math math.parser math.order prettyprint sequences splitting strings ;
IN: clock

:: two-digits ( n -- str )
    n number>string dup length 1 = [ "0" swap append ] when ;

:: <clock> ( hour minute -- str )
    hour 60 * minute + 1440 mod dup 0 < [ 1440 + ] when
    dup 60 /i :> h
    60 mod :> m
    h two-digits ":" append m two-digits append ;

:: clock-minutes ( clock -- minutes )
    clock ":" split [ string>number ] map first2 swap 60 * + ;

:: add-minutes ( clock minutes -- clock' )
    clock clock-minutes minutes + 0 swap <clock> ;

:: subtract-minutes ( clock minutes -- clock' )
    clock clock-minutes minutes - 0 swap <clock> ;

: clock= ( clock1 clock2 -- ? ) = ;
