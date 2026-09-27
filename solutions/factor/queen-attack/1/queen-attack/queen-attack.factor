USING: accessors kernel math ;
IN: queen-attack

ERROR: row-not-on-board ;
ERROR: column-not-on-board ;

TUPLE: queen row column ;

:: <queen> ( row column -- queen )
    row 0 >= row 7 <= and [ ] [ row-not-on-board ] if
    column 0 >= column 7 <= and [ ] [ column-not-on-board ] if
    row column queen boa ;

:: can-attack? ( queen1 queen2 -- ? )
    queen1 row>> queen2 row>> =
    queen1 column>> queen2 column>> = or
    queen1 row>> queen2 row>> - abs
    queen1 column>> queen2 column>> - abs = or ;
