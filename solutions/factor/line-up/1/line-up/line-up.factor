USING: kernel math math.order math.parser sequences ;
IN: line-up

:: format ( name number -- str )
    number 100 mod :> last-two
    number 10 mod :> last-digit
    last-two 11 >= last-two 13 <= and [ "th" ] [
        last-digit 1 = [ "st" ] [
            last-digit 2 = [ "nd" ] [
                last-digit 3 = [ "rd" ] [ "th" ] if
            ] if
        ] if
    ] if :> suffix
    name ", you are the " append
    number number>string append
    suffix append
    " customer we serve today. Thank you!" append ;
