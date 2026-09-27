USING: ascii grouping kernel math math.order sequences strings ;
IN: atbash-cipher

: encode ( phrase -- str )
    >lower [ dup letter? swap digit? or ] filter
    [ dup letter? [ CHAR: a - 25 swap - CHAR: a + ] when ] map
    5 group [ >string ] map " " join ;

: decode ( phrase -- str )
    >lower [ dup letter? swap digit? or ] filter
    [ dup letter? [ CHAR: a - 25 swap - CHAR: a + ] when ] map >string ;
