USING: combinators kernel math ;
IN: difference-of-squares

: square-of-sum ( n -- m )
    dup 1 + * 2 / dup * ;

: sum-of-squares ( n -- m )
    [ dup 1 + * ] [ 2 * 1 + ] bi * 6 / ;

: difference-of-squares ( n -- m )
    dup square-of-sum swap sum-of-squares - ;
