USING: arrays assocs kernel math math.order math.parser sequences sorting splitting strings vectors ;
IN: tournament

CONSTANT: header "Team                           | MP |  W |  D |  L |  P"

:: ensure-team ( team table -- stats )
    team table at :> stats
    stats [ stats ] [
        V{ 0 0 0 0 0 } clone :> created
        created team table set-at
        created
    ] if ;

:: inc-stat ( team table index amount -- )
    team table at :> stats
    index stats nth amount + index stats set-nth ;

:: update-match ( first-team second-team result table -- )
    first-team table ensure-team drop
    second-team table ensure-team drop
    first-team table 0 1 inc-stat
    second-team table 0 1 inc-stat
    result "win" = [
        first-team table 1 1 inc-stat
        first-team table 4 3 inc-stat
        second-team table 3 1 inc-stat
    ] [
        result "loss" = [
            first-team table 3 1 inc-stat
            second-team table 1 1 inc-stat
            second-team table 4 3 inc-stat
        ] [
            first-team table 2 1 inc-stat
            first-team table 4 1 inc-stat
            second-team table 2 1 inc-stat
            second-team table 4 1 inc-stat
        ] if
    ] if ;

:: pad-team ( team -- padded )
    30 team length - 0 max [ " " ] replicate "" join team swap append ;

:: pad-number ( number -- padded )
    number number>string :> text
    text length 2 < [ " " text append ] [ text ] if ;

:: format-team ( team stats -- row )
    team pad-team " | " append :> row!
    row 0 stats nth pad-number append " | " append row!
    row 1 stats nth pad-number append " | " append row!
    row 2 stats nth pad-number append " | " append row!
    row 3 stats nth pad-number append " | " append row!
    row 4 stats nth pad-number append row!
    row ;

:: ordered-teams ( table -- teams )
    table keys [| team |
        4 team table at nth neg team 2array
    ] map sort [ second ] map ;

:: tally ( rows -- lines )
    H{ } clone :> table
    rows [| row |
        row ";" split :> fields
        0 fields nth 1 fields nth 2 fields nth table update-match
    ] each
    V{ } clone :> lines
    table ordered-teams [| team |
        team table at :> stats
        team stats format-team lines push
    ] each
    header 1array lines append ;
