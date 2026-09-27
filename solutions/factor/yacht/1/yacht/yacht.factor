USING: assocs combinators kernel math math.order math.statistics sequences sorting ;
IN: yacht

:: yacht-score ( counts -- score )
    5 counts values member? [ 50 ] [ 0 ] if ;

:: full-house-score ( dice counts -- score )
    counts values :> frequencies
    frequencies length 2 =
    2 frequencies member? and
    3 frequencies member? and
    [ dice sum ] [ 0 ] if ;

:: four-kind-score ( counts -- score )
    0 :> result!
    counts keys [| face |
        face counts at 4 >= [ face 4 * result! ] when
    ] each
    result ;

:: straight-score ( dice straight -- score )
    dice sort straight = [ 30 ] [ 0 ] if ;

:: face-score ( counts category -- score )
    category H{
        { "ones" 1 }
        { "twos" 2 }
        { "threes" 3 }
        { "fours" 4 }
        { "fives" 5 }
        { "sixes" 6 }
    } at :> face
    face counts key? [ face dup counts at * ] [ 0 ] if ;

:: score ( dice category -- score )
    dice histogram :> counts
    {
        { [ category "yacht" = ] [ counts yacht-score ] }
        { [ category "full house" = ] [ dice counts full-house-score ] }
        { [ category "four of a kind" = ] [ counts four-kind-score ] }
        { [ category "little straight" = ] [ dice { 1 2 3 4 5 } straight-score ] }
        { [ category "big straight" = ] [ dice { 2 3 4 5 6 } straight-score ] }
        { [ category "choice" = ] [ dice sum ] }
        [ counts category face-score ]
    } cond ;
