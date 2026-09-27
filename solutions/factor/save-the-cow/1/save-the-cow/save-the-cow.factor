USING: kernel math sequences strings unicode ;
IN: save-the-cow

:: guess ( word guesses -- state display remaining )
    "" :> guessed!
    0 :> failures!
    guesses [| letter |
        word [| character | character guessed member? ] all?
        failures 10 = or [ "The game has ended" throw ] when
        letter guessed member? [
            failures 1 + failures!
        ] [
            letter word member? [ ] [ failures 1 + failures! ] if
        ] if
        guessed letter 1string append guessed!
    ] each
    word [| character |
        character guessed member?
        [ character ] [ CHAR: _ ] if
    ] map :> display
    display word = [ "Win" ] [
        failures 10 = [ "Lose" ] [ "Ongoing" ] if
    ] if
    display
    failures 10 = [ 0 ] [ 9 failures - ] if ;
