USING: arrays assocs hashtables kernel math sequences ;
IN: lasagna-luminary

:: cooking-status ( timer -- string )
    timer f = [ "You forgot to set the timer." ] [
        timer zero? [ "Lasagna is done." ] [ "Not done, please wait." ] if
    ] if ;

: preparation-time ( layers minutes-per-layer -- total )
    swap length * ;

:: quantities ( layers -- noodles sauce )
    layers [ "noodles" = ] count 50 *
    layers [ "sauce" = ] count 5 / ;

:: add-secret-ingredient ( friends-list my-list -- new-list )
    my-list friends-list last suffix ;

:: scale-recipe ( recipe portions -- new-recipe )
    recipe >alist [| pair |
        pair first pair second portions * 2 / 2array
    ] map >hashtable ;
