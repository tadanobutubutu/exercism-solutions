USING: combinators kernel locals math unicode ;
IN: character-study

SYMBOLS: less equal greater
    big small no-size
    alpha numeric space newline unknown ;

:: compare-chars ( c1 c2 -- symbol )
    {
        { [ c1 c2 < ] [ less ] }
        { [ c1 c2 > ] [ greater ] }
        [ equal ]
    } cond ;

:: size-of-char ( c -- symbol )
    {
        { [ c LETTER? ] [ big ] }
        { [ c letter? ] [ small ] }
        [ no-size ]
    } cond ;

:: change-size-of-char ( c desired -- c' )
    desired big = [ c ch>upper ] [ c ch>lower ] if ;

:: type-of-char ( c -- symbol )
    {
        { [ c Letter? ] [ alpha ] }
        { [ c digit? ] [ numeric ] }
        { [ c CHAR: space = ] [ space ] }
        { [ c CHAR: \n = ] [ newline ] }
        [ unknown ]
    } cond ;
