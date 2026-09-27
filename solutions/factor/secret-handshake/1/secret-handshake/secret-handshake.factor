USING: arrays kernel math sequences vectors ;
IN: secret-handshake

CONSTANT: handshake-actions { "wink" "double blink" "close your eyes" "jump" }

:: commands ( number -- actions )
    V{ } clone :> result
    4 <iota> [| index |
        number index 2^ /i 2 mod 1 = [
            index handshake-actions nth result push
        ] when
    ] each
    number 16 /i 2 mod 1 = [ result reverse ] [ result ] if >array ;
