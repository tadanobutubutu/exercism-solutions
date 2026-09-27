USING: accessors kernel math ;
IN: dragons-descendants

TUPLE: dragon name color age ;
TUPLE: fire-dragon < dragon flame-temp ;
TUPLE: ice-dragon < dragon chill-temp ;
TUPLE: volcano-dragon < fire-dragon lava-volume ;

: <dragon> ( name color age -- dragon )
    dragon boa ;

: <fire-dragon> ( name color age flame-temp -- fd )
    fire-dragon boa ;

: <ice-dragon> ( name color age chill-temp -- id )
    ice-dragon boa ;

: <volcano-dragon> ( name color age flame-temp lava-volume -- vd )
    volcano-dragon boa ;

: age-dragon ( dragon -- )
    dup age>> 1 + >>age drop ;
