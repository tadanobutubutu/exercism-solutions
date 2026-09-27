USING: kernel math random random.mersenne-twister sequences ;
IN: boardwalk-games

: roll-die ( sides -- n )
    random 1 + ;

: pick-prize ( prizes -- prize )
    random ;

: shuffle-deck ( deck -- deck' )
    clone randomize ;

: deal-hand ( deck n -- hand )
    [ clone ] dip sample ;

:: play-seeded ( seed quot -- result )
    seed <mersenne-twister> quot with-random ; inline
