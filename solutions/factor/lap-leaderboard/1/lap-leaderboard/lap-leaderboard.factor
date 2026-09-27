USING: arrays kernel math math.parser sequences strings ;
IN: lap-leaderboard

: assign-bibs ( names -- pairs )
    [ swap 2array ] map-index ;

: lane-labels ( names -- labels )
    [| name index |
        "Lane " index number>string append ": " append name append
    ] map-index ;

:: tag-racers ( names tag -- tagged )
    names [| name index |
        tag "/" append index number>string append ": " append name append
    ] map-index ;

:: record-finishes ( names ledger -- )
    names [| name index |
        index number>string ": " append name append ledger push
    ] each-index ;

: lap-bells ( laps -- str )
    "" swap [ "ding " append ] times ;
