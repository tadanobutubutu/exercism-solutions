USING: arrays combinators kernel math sequences splitting ;
IN: kindergarten-garden

CONSTANT: students {
    "Alice" "Bob" "Charlie" "David" "Eve" "Fred"
    "Ginny" "Harriet" "Ileana" "Joseph" "Kincaid" "Larry"
}

:: seed-name ( seed -- plant )
    seed {
        { CHAR: V [ "violets" ] }
        { CHAR: C [ "clover" ] }
        { CHAR: R [ "radishes" ] }
        { CHAR: G [ "grass" ] }
    } case ;

:: plants ( diagram student -- plants )
    diagram "\n" split :> rows
    student students index 2 * :> start
    start rows first nth
    start 1 + rows first nth
    start rows second nth
    start 1 + rows second nth
    4array [ seed-name ] map ;
