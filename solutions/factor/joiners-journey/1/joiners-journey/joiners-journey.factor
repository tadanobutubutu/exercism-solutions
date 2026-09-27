USING: kernel math ;
IN: joiners-journey

: with-kerf ( length -- length+kerf )
    [ 1/50 * ] keep + ;

: kerf-and-finish ( length -- kerf finish )
    [ 1/50 * ] [ 1/20 * ] bi ;

: cut-card ( length -- length kerf finish )
    [ kerf-and-finish ] keep -rot ;

: per-piece ( bolt-length pieces -- per-piece )
    [ 51/50 * ] dip / ;

: compare-bolts ( length-a length-b -- kerf-a kerf-b )
    [ 1/50 * ] bi@ ;
