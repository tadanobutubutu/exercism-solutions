USING: accessors kernel locals math sequences vectors ;
IN: bowling

TUPLE: game rolls ;

:: <game> ( -- game )
    game new V{ } clone >>rolls ;

:: first-nine-state ( rolls -- index frame )
    0 :> index!
    0 :> frame!
    [
        frame 9 < index rolls length < and
        [ index rolls nth 10 = [ t ] [ index 1 + rolls length < ] if ] [ f ] if
    ] [
        index rolls nth 10 = [
            index 1 + index!
        ] [
            index 2 + index!
        ] if
        frame 1 + frame!
    ] while
    index frame ;

:: game-complete? ( rolls -- ? )
    rolls first-nine-state :> frame :> index
    frame 9 < [ f ] [
        rolls length index - :> count
        count 0 = [ f ] [
            index rolls nth :> first
            first 10 = [ count 3 >= ] [
                count 1 = [ f ] [
                    count 2 = [
                        first index 1 + rolls nth + 10 <
                    ] [ t ] if
                ] if
            ] if
        ] if
    ] if ;

:: next-roll-limit ( rolls -- pins )
    rolls first-nine-state :> frame :> index
    rolls length index - :> count
    frame 9 < [
        count 0 = [ 10 ] [ 10 index rolls nth - ] if
    ] [
        count 0 = [ 10 ] [
            index rolls nth :> first
            count 1 = [
                first 10 = [ 10 ] [ 10 first - ] if
            ] [
                first 10 = [
                    index 1 + rolls nth :> second
                    second 10 = [ 10 ] [ 10 second - ] if
                ] [ 10 ] if
            ] if
        ] if
    ] if ;

:: roll ( pins game -- )
    pins 0 < [ "Negative roll is invalid" throw ] when
    game rolls>> :> rolls
    rolls game-complete? [ "Cannot roll after game is over" throw ] when
    pins rolls next-roll-limit > [ "Pin count exceeds pins on the lane" throw ] when
    pins rolls push ;

:: score ( game -- n )
    game rolls>> :> rolls
    rolls game-complete? not [ "Score cannot be taken until the end of the game" throw ] when
    0 :> index!
    0 :> total!
    9 <iota> [| frame |
        index rolls nth :> first
        first 10 = [
            total 10 +
            index 1 + rolls nth +
            index 2 + rolls nth + total!
            index 1 + index!
        ] [
            index 1 + rolls nth :> second
            first second + :> frame-score!
            first second + 10 = [
                frame-score index 2 + rolls nth + frame-score!
            ] when
            total frame-score + total!
            index 2 + index!
        ] if
    ] each
    rolls length index - <iota> [| offset |
        index offset + rolls nth
    ] map sum
    total + ;
