USING: ascii kernel math math.order sequences strings ;
IN: phone-number

ERROR: invalid-phone-number ;

: allowed-character? ( ch -- ? )
    dup digit? [ drop t ] [ "+-(). " member? ] if ;

: valid-leading-digit? ( ch -- ? )
    CHAR: 2 CHAR: 9 between? ;

:: clean ( phrase -- digits )
    phrase [ allowed-character? ] all? [ ] [ invalid-phone-number ] if
    phrase [ digit? ] filter >string :> digits
    digits length 11 = [
        digits first CHAR: 1 = [ digits rest ] [ invalid-phone-number ] if
    ] [ digits ] if :> normalized
    normalized length 10 = [
        normalized first valid-leading-digit? 3 normalized nth valid-leading-digit? and
        [ normalized ] [ invalid-phone-number ] if
    ] [ invalid-phone-number ] if ;
