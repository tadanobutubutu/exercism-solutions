USING: accessors combinators kernel math math.constants math.functions namespaces ;
IN: bering-bearings

SYMBOLS: north east south west ahead starboard behind port ;
SYMBOL: heading

TUPLE: cardinal direction ;
TUPLE: polar magnitude bearing ;
TUPLE: relative distance bearing ;

GENERIC: >cartesian ( direction -- x y )
GENERIC: flip ( direction -- direction' )

M:: cardinal >cartesian ( point -- x y )
    point direction>> {
        { north [ 0 1 ] }
        { east  [ 1 0 ] }
        { south [ 0 -1 ] }
        { west  [ -1 0 ] }
    } case ;

:: degrees>radians ( degrees -- radians )
    degrees 360 mod pi * 180 / ;

M:: polar >cartesian ( point -- x y )
    point bearing>> degrees>radians :> angle
    point magnitude>> angle sin *
    point magnitude>> angle cos * ;

:: relative-offset ( direction -- degrees )
    direction {
        { ahead [ 0 ] }
        { starboard [ 90 ] }
        { behind [ 180 ] }
        { port [ 270 ] }
    } case ;

M:: relative >cartesian ( point -- x y )
    heading get point bearing>> relative-offset + degrees>radians :> angle
    point distance>> angle sin *
    point distance>> angle cos * ;

M:: cardinal flip ( point -- opposite )
    point direction>> {
        { north [ south ] }
        { south [ north ] }
        { east [ west ] }
        { west [ east ] }
    } case
    cardinal new swap >>direction ;

M:: polar flip ( point -- opposite )
    polar new
        point magnitude>> >>magnitude
        point bearing>> 180 + 360 mod >>bearing ;

M:: relative flip ( point -- opposite )
    point bearing>> {
        { ahead [ behind ] }
        { behind [ ahead ] }
        { starboard [ port ] }
        { port [ starboard ] }
    } case :> opposite-bearing
    relative new
        point distance>> >>distance
        opposite-bearing >>bearing ;

:: add-bearings ( a b -- x y )
    a >cartesian :> ay :> ax
    b >cartesian :> by :> bx
    ax bx + ay by + ;
