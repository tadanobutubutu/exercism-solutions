USING: arrays kernel math sequences ;
IN: bottle-song

: number-word ( count -- word )
    { "no" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten" } nth ;

:: bottle-line ( count -- line )
    count { "no" "One" "Two" "Three" "Four" "Five" "Six" "Seven" "Eight" "Nine" "Ten" } nth
    count 1 = [ " green bottle" ] [ " green bottles" ] if append
    " hanging on the wall" append ;

:: recite ( start take -- lines )
    V{ } clone :> lines
    take <iota> [| offset |
        offset 0 > [ "" lines push ] when
        start offset - :> count
        count bottle-line "," append :> line
        line lines push
        line lines push
        "And if one green bottle should accidentally fall," lines push
        count 1 - number-word
        count 1 - 1 = [ " green bottle" ] [ " green bottles" ] if append
        " hanging on the wall" append "There'll be " swap append "." append lines push
    ] each
    lines >array ;
