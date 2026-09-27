USING: arrays kernel math math.order sequences ;
IN: spiral-matrix

:: spiral-matrix ( n -- matrix )
    n [ n [ 0 ] replicate >array ] replicate >array :> matrix
    0 :> top!
    0 :> left!
    n 1 - :> bottom!
    n 1 - :> right!
    1 :> value!
    [ left right <= top bottom <= and ] [
        left :> column!
        [ column right <= ] [
            value column top matrix nth set-nth
            value 1 + value!
            column 1 + column!
        ] while
        top 1 + top!

        top :> row!
        [ row bottom <= ] [
            value right row matrix nth set-nth
            value 1 + value!
            row 1 + row!
        ] while
        right 1 - right!

        top bottom <= [
            right :> column!
            [ left column <= ] [
                value column bottom matrix nth set-nth
                value 1 + value!
                column 1 - column!
            ] while
        ] when
        bottom 1 - bottom!

        left right <= [
            bottom :> row!
            [ top row <= ] [
                value left row matrix nth set-nth
                value 1 + value!
                row 1 - row!
            ] while
        ] when
        left 1 + left!
    ] while
    matrix ;
