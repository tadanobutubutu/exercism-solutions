USING: accessors kernel math math.order ;
IN: role-playing-game

TUPLE: player
    { name }
    { level initial: 0 }
    { health initial: 100 }
    { mana } ;

: introduce ( player -- name )
    name>> dup [ ] [ drop "Mighty Magician" ] if ;

:: revive ( player -- player' )
    player health>> zero?
    [ player clone 100 >>health 100 >>mana ]
    [ f ] if ;

:: take-damage ( player damage -- player' )
    player clone dup health>> damage - 0 max >>health ;
