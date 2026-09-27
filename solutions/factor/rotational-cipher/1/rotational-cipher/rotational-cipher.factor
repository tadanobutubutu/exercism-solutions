USING: kernel math math.order math.parser sequences strings unicode ;
IN: rotational-cipher

:: rotate ( text key -- cipher )
    text [| ch |
        ch CHAR: a CHAR: z between? [
            ch CHAR: a - key + 26 mod CHAR: a +
        ] [
            ch CHAR: A CHAR: Z between? [
                ch CHAR: A - key + 26 mod CHAR: A +
            ] [ ch ] if
        ] if
    ] map >string ;
