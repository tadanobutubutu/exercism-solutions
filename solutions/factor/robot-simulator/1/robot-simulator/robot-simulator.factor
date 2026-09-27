USING: accessors kernel math sequences ;
IN: robot-simulator

! Declare a symbol per direction (north, east, south, west) and a
! `robot` tuple so the tests can refer to them by name.

SYMBOL: north
SYMBOL: east
SYMBOL: south
SYMBOL: west

TUPLE: robot x y direction ;

: <robot> ( x y direction -- robot )
    robot boa ;

:: turn-right ( bot -- bot )
    bot direction>> north = [ bot east >>direction ] [
        bot direction>> east = [ bot south >>direction ] [
            bot direction>> south = [ bot west >>direction ] [ bot north >>direction ] if
        ] if
    ] if ;

:: turn-left ( bot -- bot )
    bot direction>> north = [ bot west >>direction ] [
        bot direction>> west = [ bot south >>direction ] [
            bot direction>> south = [ bot east >>direction ] [ bot north >>direction ] if
        ] if
    ] if ;

:: advance ( bot -- bot )
    bot direction>> north = [ bot dup y>> 1 + >>y ] [
        bot direction>> south = [ bot dup y>> 1 - >>y ] [
            bot direction>> east = [ bot dup x>> 1 + >>x ] [ bot dup x>> 1 - >>x ] if
        ] if
    ] if ;

:: execute-instruction ( bot instruction -- bot )
    instruction CHAR: R = [ bot turn-right ] [
        instruction CHAR: L = [ bot turn-left ] [ bot advance ] if
    ] if ;

:: move ( bot instructions -- robot )
    bot clone :> result
    instructions [| instruction | result instruction execute-instruction drop ] each
    result ;
