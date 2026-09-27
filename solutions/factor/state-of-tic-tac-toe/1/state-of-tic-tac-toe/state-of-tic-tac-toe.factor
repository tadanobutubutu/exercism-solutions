USING: arrays kernel math math.order sequences ;
IN: state-of-tic-tac-toe

CONSTANT: winning-lines {
    { 0 1 2 } { 3 4 5 } { 6 7 8 }
    { 0 3 6 } { 1 4 7 } { 2 5 8 }
    { 0 4 8 } { 2 4 6 }
}

:: has-won? ( board mark -- ? )
    winning-lines [| line |
        line [| index | index board nth mark = ] all?
    ] any? ;

:: can-be-last-move? ( board mark -- ? )
    9 <iota> [| index |
        index board nth mark = [
            board clone :> previous
            CHAR: space index previous set-nth
            previous mark has-won? not
        ] [ f ] if
    ] any? ;

:: gamestate ( rows -- state )
    rows [ >array ] map concat >array :> board
    board [ CHAR: X = ] count :> x-count
    board [ CHAR: O = ] count :> o-count
    x-count o-count 1 + > [ "Wrong turn order: X went twice" throw ] when
    o-count x-count > [ "Wrong turn order: O started" throw ] when

    board CHAR: X has-won? :> x-won
    board CHAR: O has-won? :> o-won
    x-won o-won and [
        "Impossible board: game should have ended after the game was won" throw
    ] when
    x-won [
        x-count o-count 1 + = not [
            "Impossible board: game should have ended after the game was won" throw
        ] when
        board CHAR: X can-be-last-move? not [
            "Impossible board: game should have ended after the game was won" throw
        ] when
    ] when
    o-won [
        x-count o-count = not [
            "Impossible board: game should have ended after the game was won" throw
        ] when
        board CHAR: O can-be-last-move? not [
            "Impossible board: game should have ended after the game was won" throw
        ] when
    ] when

    x-won o-won or [ "win" ] [
        board [ CHAR: space = ] any? [ "ongoing" ] [ "draw" ] if
    ] if ;
