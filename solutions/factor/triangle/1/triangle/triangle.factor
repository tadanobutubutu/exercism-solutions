USING: accessors kernel locals math math.order ;
IN: triangle

! Declare a `triangle` tuple with slots a, b, and c.
TUPLE: triangle a b c ;

: <triangle> ( a b c -- triangle )
    triangle boa ;

:: valid? ( tri -- ? )
    tri a>> 0 > tri b>> 0 > and tri c>> 0 > and
    tri a>> tri b>> + tri c>> >= and
    tri b>> tri c>> + tri a>> >= and
    tri a>> tri c>> + tri b>> >= and ;

:: equilateral? ( tri -- ? )
    tri valid? [
        tri a>> tri b>> = tri b>> tri c>> = and
    ] [ f ] if ;

:: isosceles? ( tri -- ? )
    tri valid? [
        tri a>> tri b>> = tri b>> tri c>> = or tri a>> tri c>> = or
    ] [ f ] if ;

:: scalene? ( tri -- ? )
    tri valid? [
        tri a>> tri b>> = not
        tri b>> tri c>> = not and
        tri a>> tri c>> = not and
    ] [ f ] if ;
