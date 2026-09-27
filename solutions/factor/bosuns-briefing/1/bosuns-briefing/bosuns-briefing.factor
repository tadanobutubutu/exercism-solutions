USING: bosuns-briefing.helpers kernel sequences strings ;
IN: bosuns-briefing

: roster ( names -- str )
    [ crew-line ] map "\n" join ;

:: briefing ( names -- str )
    greeting "\n" append
    names roster append
    "\n" append closing append ;
