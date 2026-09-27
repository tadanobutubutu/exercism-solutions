USING: accessors arrays assocs deques dlists hash-sets hashtables
kernel locals math memoize sequences sets vectors ;
IN: pirates-path

CONSTANT: gold-distribution H{
    { "Hidden Cove" 80 }
    { "Skull Bay" 120 }
    { "Reef Point" 40 }
    { "Smuggler's Hollow" 200 }
    { "Plank Island" 60 }
    { "Lantern Rock" 150 }
}

:: tide-queue ( items -- popped )
    <dlist> :> queue
    items [| item | item queue push-back ] each
    V{ } clone :> popped
    [ queue deque-empty? ] [ queue pop-front popped push ] until
    popped >array ;

:: coves-reachable ( start chart -- coves )
    HS{ } clone :> visited
    <dlist> :> frontier
    start visited adjoin
    start frontier push-back
    [ frontier deque-empty? ] [
        frontier pop-front :> current
        current chart at :> neighbours
        neighbours [
            neighbours [| neighbour |
                neighbour visited in? not [
                    neighbour visited adjoin
                    neighbour frontier push-back
                ] when
            ] each
        ] when
    ] until
    visited ;

:: hop-count ( start goal chart -- n/f )
    start goal = [ 0 ] [
        HS{ } clone :> visited
        <dlist> :> frontier
        start visited adjoin
        start 0 2array frontier push-back
        f :> answer!
        [ frontier deque-empty? answer or ] [
            frontier pop-front :> entry
            entry first :> current
            entry second :> distance
            current goal = [
                distance answer!
            ] [
                current chart at :> neighbours
                neighbours [
                    neighbours [| neighbour |
                        neighbour visited in? not [
                            neighbour visited adjoin
                            neighbour distance 1 + 2array frontier push-back
                        ] when
                    ] each
                ] when
            ] if
        ] until
        answer
    ] if ;

MEMO: gold-count ( cove -- n )
    cove gold-distribution at* [ ] [ drop 0 ] if ;

:: treasure-route ( start chart -- best-cove )
    start chart coves-reachable members :> reachable
    reachable first :> best!
    reachable [| cove |
        cove gold-count best gold-count > [ cove best! ] when
    ] each
    best ;
