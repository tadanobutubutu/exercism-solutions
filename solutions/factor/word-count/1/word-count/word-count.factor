USING: assocs ascii kernel math regexp sequences ;
IN: word-count

:: count-words ( sentence -- counts )
    H{ } clone :> counts
    sentence >lower R/ [a-z0-9]+(?:'[a-z0-9]+)?/ all-matching-subseqs [| word |
        word counts at :> previous
        previous [ previous 1 + ] [ 1 ] if :> count
        count word counts set-at
    ] each
    counts ;
