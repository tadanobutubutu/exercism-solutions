USING: arrays kernel math.vectors sequences ;
IN: coordinate-choreography

: translate-2d ( dx dy -- quot )
    '[ _ _ 2array v+ ] ;

: scale-2d ( sx sy -- quot )
    '[ _ _ 2array v* ] ;

: compose-transformations ( f g -- h )
    compose ;

:: apply-transformation ( point f -- point' )
    point f call( p -- p' ) ;

:: transform-points ( points f -- points' )
    points [ f call( p -- p' ) ] map ;
