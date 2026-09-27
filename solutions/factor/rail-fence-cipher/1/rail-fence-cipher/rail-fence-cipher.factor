USING: arrays kernel math math.order sequences strings unicode vectors ;
IN: rail-fence-cipher

:: rail-for ( index rails -- rail )
    rails 1 <= [ 0 ] [
        rails 1 - 2 * :> cycle
        index cycle mod :> offset
        offset rails < [ offset ] [ cycle offset - ] if
    ] if ;

:: indexed-characters ( msg -- pairs )
    msg [ 2array ] { } map-index-as ;

:: encode ( msg rails -- cipher )
    rails 1 <= [ msg ] [
        msg indexed-characters :> pairs
        rails <iota> [| rail |
            pairs [| pair | pair second rails rail-for rail = ] filter
            [ first ] map [ 1string ] map "" join
        ] { } map-as "" join
    ] if ;

:: decode ( msg rails -- plain )
    rails 1 <= [ msg ] [
        msg length :> size
        rails [ V{ } clone ] replicate :> positions
        size <iota> [| index |
            index rails rail-for :> rail
            index rail positions nth push
        ] each
        size [ CHAR: space ] replicate :> characters!
        0 :> cipher-index!
        positions [| row-positions |
            row-positions [| plain-index |
                cipher-index msg nth :> character
                character plain-index characters set-nth
                cipher-index 1 + cipher-index!
            ] each
        ] each
        characters [ 1string ] map "" join
    ] if ;
