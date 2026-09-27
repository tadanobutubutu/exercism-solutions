USING: accessors arrays concurrency.combinators concurrency.locks
       concurrency.promises kernel locals math math.statistics sequences threads ;
IN: quayside-crew

: weigh-crate ( crate -- weight )
    sum ;

: weigh-all ( crates -- weights )
    [ weigh-crate ] parallel-map ;

TUPLE: crane lock tonnage ;

: <crane> ( -- crane )
    <lock> 0 crane boa ;

:: hoist-crate ( weight crane -- )
    crane lock>> [
        crane dup tonnage>> weight + >>tonnage drop
    ] with-lock ;

:: crane-tonnage ( crane -- tonnage )
    f :> current!
    crane lock>> [ crane tonnage>> current! ] with-lock
    current ;

:: load-cargo ( crates crane -- )
    crates [| crate |
        <promise> :> done
        [ crate weigh-crate crane hoist-crate t done fulfill ]
        "dockhand" spawn drop
        done
    ] map [ ?promise drop ] each ;
