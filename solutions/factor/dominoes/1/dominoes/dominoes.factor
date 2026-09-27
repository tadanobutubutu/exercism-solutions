USING: arrays kernel math sequences vectors ;
IN: dominoes

:: add-neighbor ( graph degrees source destination -- )
    destination source graph nth push
    source degrees nth 1 + source degrees set-nth ;

:: visit-connected ( start graph visited -- )
    V{ } clone :> pending
    t start visited set-nth
    start pending push
    [ pending empty? not ] [
        pending pop :> vertex
        vertex graph nth [| neighbor |
            neighbor visited nth not [
                t neighbor visited set-nth
                neighbor pending push
            ] when
        ] each
    ] while ;

:: can-chain? ( dominoes -- ? )
    dominoes empty? [ t ] [
        16 [ V{ } clone ] replicate :> graph
        16 [ 0 ] replicate :> degrees
        dominoes [| domino |
            domino 16 /i :> left
            domino 16 mod :> right
            graph degrees left right add-neighbor
            graph degrees right left add-neighbor
        ] each
        degrees [ even? ] all? [
            f :> start!
            16 <iota> [| vertex |
                vertex degrees nth 0 > start f = and [ vertex start! ] when
            ] each
            start f = [ t ] [
                16 [ f ] replicate :> visited
                start graph visited visit-connected
                16 <iota> [| vertex |
                    vertex degrees nth 0 = [ t ] [ vertex visited nth ] if
                ] all?
            ] if
        ] [ f ] if
    ] if ;
