USING: kernel math sequences splitting strings ;
IN: pig-latin

:: translate-word ( word -- result )
    word first "aeiou" member? :> vowel-start
    word length 2 >= [
        0 2 word subseq { "xr" "yt" } member?
    ] [ f ] if :> special-start
    vowel-start special-start or [
        word "ay" append
    ] [
        0 :> index!
        f :> stopped!
        [ stopped not index word length < and ] [
            index word nth :> ch
            ch CHAR: u = index 0 > and [
                index 1 - word nth CHAR: q = [
                    index 1 + index!
                    t stopped!
                ] [ t stopped! ] if
            ] [
                ch "aeiou" member? ch CHAR: y = index 0 > and or [
                    t stopped!
                ] [ index 1 + index! ] if
            ] if
        ] while
        index word length word subseq :> ending
        0 index word subseq :> beginning
        ending beginning append "ay" append
    ] if ;

:: translate ( phrase -- result )
    phrase empty? [ "" ] [
        phrase " " split [ translate-word ] map " " join
    ] if ;
