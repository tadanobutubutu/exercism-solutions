USING: accessors kernel math namespaces sequences ;
IN: garden-gathering

TUPLE: plot id registered-to ;

SYMBOLS: registrations next-id not-found ;

: open-garden ( -- )
    V{ } clone registrations set-global
    1 next-id set-global ;

: list-registrations ( -- plots )
    registrations get-global ;

:: register ( name -- plot' )
    next-id get-global :> id
    id name plot boa :> new-plot
    new-plot registrations get-global push
    id 1 + next-id set-global
    new-plot ;

:: release ( id -- )
    registrations get-global
    [| current | current id>> id = not ] filter
    registrations set-global ;

:: get-registration ( id -- plot/symbol )
    registrations get-global
    [| current | current id>> id = ] find nip
    dup [ ] [ drop not-found ] if ;

:: find-by-name ( name -- plots )
    registrations get-global
    [| current | current registered-to>> name = ] filter ;
