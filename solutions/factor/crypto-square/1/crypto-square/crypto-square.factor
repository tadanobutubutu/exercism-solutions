USING: arrays ascii kernel math math.order sequences strings ;
IN: crypto-square

:: ciphertext ( plaintext -- cipher )
    plaintext >lower [ dup letter? swap digit? or ] filter :> chars
    chars length :> size
    size 0 = [ "" ] [
        1 :> columns!
        [ columns columns * size < ] [ columns 1 + columns! ] while
        size columns + 1 - columns /i :> rows
        columns <iota> [| column |
            rows <iota> [| row |
                row columns * column + :> index
                index size < [ index chars nth ] [ CHAR: space ] if
            ] map >string
        ] map " " join
    ] if ;
