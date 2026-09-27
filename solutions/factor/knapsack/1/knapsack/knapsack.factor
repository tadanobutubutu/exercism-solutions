USING: accessors kernel math math.order sequences ;
IN: knapsack

TUPLE: item weight value ;

:: maximum-value ( capacity items -- max-value )
    items empty? [ 0 ] [
        items first :> current
        items rest :> remaining
        capacity remaining maximum-value :> without-current
        current weight>> capacity <= [
            capacity current weight>> - remaining maximum-value
            current value>> + :> with-current
            without-current with-current max
        ] [
            without-current
        ] if
    ] if ;
