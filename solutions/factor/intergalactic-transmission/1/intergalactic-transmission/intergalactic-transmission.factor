USING: grouping kernel math sequences ;
IN: intergalactic-transmission

:: byte-bits ( byte -- bits )
    { 7 6 5 4 3 2 1 0 } [| shift |
        byte shift 2^ /i 2 mod
    ] map ;

:: seven-bits ( value -- bits )
    { 6 5 4 3 2 1 0 } [| shift |
        value shift 2^ /i 2 mod
    ] map ;

:: encode-group ( bits -- transmitted )
    0 :> value!
    bits [| bit | value 2 * bit + value! ] each
    value 2 * bits [ 1 = ] count 2 mod + ;

:: transmit-sequence ( message -- sequence )
    message [ byte-bits ] map concat :> bits
    bits length 7 mod :> remainder
    remainder 0 > [ bits 7 remainder - 0 <repetition> append ] [ bits ] if
    7 <groups> [ encode-group ] map ;

:: bit-count ( value -- count )
    value zero? [ 0 ] [ value 2 mod value 2 /i bit-count + ] if ;

:: bits-value ( bits -- value )
    0 :> value!
    bits [| bit | value 2 * bit + value! ] each
    value ;

:: decode-message ( sequence -- message )
    sequence [ bit-count 2 mod zero? ] all?
    [ ] [ "wrong parity" throw ] if
    sequence [ 2 /i seven-bits ] map concat :> bits
    sequence length 7 * 8 /i 8 * :> bit-length
    bits bit-length head
    8 <groups> [ bits-value ] map ;
