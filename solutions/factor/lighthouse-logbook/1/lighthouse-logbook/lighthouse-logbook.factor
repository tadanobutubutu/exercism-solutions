USING: assocs hash-sets kernel math math.order sequences sets vectors ;
IN: lighthouse-logbook

: empty-log ( -- log )
    HS{ } clone ;

: sight ( log callsign -- )
    swap adjoin ;

: seen? ( log callsign -- ? )
    swap in? ;

: forget-sighting ( log callsign -- )
    swap delete ;

: unique-count ( log -- n )
    cardinality ;

:: reachable ( start relay-map -- visited )
    HS{ } clone :> visited
    V{ } clone :> queue
    start visited adjoin
    start queue push
    0 :> index!
    [ index queue length < ] [
        index queue nth :> current
        current relay-map at [| neighbour |
            neighbour visited in? not [
                neighbour visited adjoin
                neighbour queue push
            ] when
        ] each
        index 1 + index!
    ] while
    visited ;
