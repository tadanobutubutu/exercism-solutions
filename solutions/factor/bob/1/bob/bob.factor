USING: ascii kernel sequences ;
IN: bob

: question? ( str -- ? )
    dup empty? [ drop f ] [ last CHAR: ? = ] if ;

: yelling? ( str -- ? )
    dup [ Letter? ] any? [ dup >upper = ] [ drop f ] if ;

:: response ( str -- reply )
    str [ blank? ] trim :> message
    message empty? [ "Fine. Be that way!" ] [
        message yelling? message question? and
        [ "Calm down, I know what I'm doing!" ] [
            message yelling? [ "Whoa, chill out!" ] [
                message question? [ "Sure." ] [ "Whatever." ] if
            ] if
        ] if
    ] if ;
