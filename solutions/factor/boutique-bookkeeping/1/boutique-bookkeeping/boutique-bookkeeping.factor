USING: kernel locals math math.order math.parser sequences sorting ;
IN: boutique-bookkeeping

:: sort-by-price ( inventory -- sorted )
    inventory [ second ] sort-by ;

:: with-missing-price ( inventory -- filtered )
    inventory [ second not ] filter ;

:: expensive-items ( inventory threshold -- count )
    inventory [ second threshold > ] count ;

:: cheapest-item ( inventory -- item )
    inventory [ second ] sort-by first ;

:: total-price ( inventory -- sum )
    inventory [ second ] map sum ;

:: format-price-tag ( item -- str )
    item first :> name
    item second number>string :> price-string
    name ": $" append price-string append ;
