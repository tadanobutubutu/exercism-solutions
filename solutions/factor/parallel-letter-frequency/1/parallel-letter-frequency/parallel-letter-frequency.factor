USING: assocs concurrency.combinators kernel sequences unicode ;
IN: parallel-letter-frequency

:: text-frequencies ( text -- counts )
    H{ } clone :> counts
    text >lower [ Letter? ] filter [| letter | 1 letter counts at+ ] each
    counts ;

:: calculate-frequencies ( texts -- counts )
    texts [ text-frequencies ] parallel-map :> partials
    H{ } clone :> counts
    partials [| partial |
        partial [| letter count | count letter counts at+ ] assoc-each
    ] each
    counts ;
