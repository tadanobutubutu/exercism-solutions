USING: accessors hash-sets kernel namespaces random sequences sets strings ;
IN: robot-name

TUPLE: robot name ;

SYMBOL: assigned-names
HS{ } clone assigned-names set-global

: make-name ( -- name )
    2 [ "ABCDEFGHIJKLMNOPQRSTUVWXYZ" random ] replicate
    3 [ "0123456789" random ] replicate append >string ;

:: fresh-name ( -- name )
    make-name :> candidate
    candidate assigned-names get in?
    [ fresh-name ]
    [ candidate assigned-names get adjoin candidate ] if ;

: <robot> ( -- robot )
    robot new fresh-name >>name ;

: reset-name ( robot -- )
    fresh-name >>name drop ;
