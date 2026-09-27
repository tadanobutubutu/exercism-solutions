USING: arrays kernel math math.order sequences ;
IN: valentines-day

SYMBOLS: yes no maybe
    korean turkish
    crime horror romance thriller
    board-game chill movie restaurant walk ;

: rate-restaurant ( cuisine -- approval )
    korean = [ yes ] [ maybe ] if ;

: rate-movie ( genre -- approval )
    romance = [ yes ] [ no ] if ;

:: rate-walk ( km -- approval )
    km 11 > [ yes ] [ km 6 > [ maybe ] [ no ] if ] if ;

:: rate-activity ( activity -- approval )
    activity first :> tag
    activity second :> value
    tag board-game = tag chill = or [ no ] [
        tag movie = [ value rate-movie ] [
            tag restaurant = [ value rate-restaurant ] [ value rate-walk ] if
        ] if
    ] if ;

:: approval-counts ( activities -- counts )
    V{ 0 0 0 } clone :> tally
    activities [| activity |
        activity rate-activity
        dup yes = [ drop 0 tally [ 1 + ] change-nth ] [
            dup maybe = [ drop 1 tally [ 1 + ] change-nth ] [
                drop 2 tally [ 1 + ] change-nth
            ] if
        ] if
    ] each
    tally >array ;
