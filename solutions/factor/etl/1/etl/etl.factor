USING: assocs kernel sequences unicode ;
IN: etl

:: transform ( legacy -- new )
    H{ } clone :> result
    legacy [| score letters |
        letters [| letter |
            score letter >lower result set-at
        ] each
    ] assoc-each
    result ;
