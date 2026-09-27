USING: combinators kernel sequences ;
IN: resistor-color-duo

: color>code ( color -- n )
    { "black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white" } swap index ;

: value ( colors -- n )
    first2 [ color>code ] bi@ swap 10 * + ;
