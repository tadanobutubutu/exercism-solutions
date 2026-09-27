USING: kernel math math.parser sequences unicode ;
IN: isbn-verifier

:: valid? ( isbn -- ? )
    isbn [ CHAR: - = not ] filter :> digits
    digits length 10 = [
        digits 9 head [ digit? ] all?
        digits last dup digit? swap CHAR: X = or and
        [
            digits [ dup CHAR: X = [ drop 10 ] [ digit> ] if ] map
            [ 10 swap - * ] map-index sum 11 mod zero?
        ] [ f ] if
    ] [ f ] if ;
