USING: kernel math sequences strings ;
IN: diamond

:: spaces ( count -- str )
    count [ " " ] replicate concat >string ;

:: diamond-row ( letter widest-offset -- row )
    letter CHAR: A - :> offset
    widest-offset offset - spaces :> outside
    letter 1string :> glyph
    outside glyph append :> start
    letter CHAR: A = [
        start outside append
    ] [
        start offset 2 * 1 - spaces append glyph append outside append
    ] if ;

:: rows ( letter -- rows )
    letter CHAR: A - :> widest-offset
    widest-offset 1 + <iota>
    [| offset | CHAR: A offset + widest-offset diamond-row ] map
    widest-offset <iota> reverse
    [| offset | CHAR: A offset + widest-offset diamond-row ] map
    append ;
