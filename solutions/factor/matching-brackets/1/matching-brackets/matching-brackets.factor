USING: kernel math sequences vectors ;
IN: matching-brackets

:: matching-opener ( closer -- opener )
    closer CHAR: ) = [ CHAR: ( ] [
        closer CHAR: ] = [ CHAR: [ ] [ CHAR: { ] if
    ] if ;

:: paired? ( str -- ? )
    V{ } clone :> stack
    0 :> index!
    t :> valid!
    [ index str length < valid and ] [
        index str nth :> ch
        ch "([{" member? [ ch stack push ] when
        ch ")]}" member? [
            stack empty? [
                f valid!
            ] [
                stack pop ch matching-opener = not [ f valid! ] when
            ] if
        ] when
        index 1 + index!
    ] while
    valid stack empty? and ;
