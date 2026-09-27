USING: kernel math math.parser sequences splitting strings ;
IN: wordy

ERROR: invalid-question ;

:: parse-number ( token -- value )
    token string>number :> value
    value f = [ invalid-question ] when
    value ;

:: apply-operation ( left operator right -- value )
    operator "plus" = [ left right + ] [
        operator "minus" = [ left right - ] [
            operator "multiplied" = [ left right * ] [
                operator "divided" = [ left right /i ] [ invalid-question ] if
            ] if
        ] if
    ] if ;

:: answer ( question -- result )
    question length 10 < [ invalid-question ] [
        0 8 question subseq "What is " = not [ invalid-question ] [
            question length 1 - question nth CHAR: ? = not [ invalid-question ] [
                8 question length 1 - question subseq " " split :> tokens
                tokens empty? [ invalid-question ] when
                0 tokens nth parse-number :> result!
                1 :> index!
                [ index tokens length < ] [
                    index tokens nth :> operator
                    operator "plus" = operator "minus" = or [
                        index 1 + index!
                    ] [
                        operator "multiplied" = operator "divided" = or [
                            index 1 + tokens length < [ ] [ invalid-question ] if
                            index 1 + tokens nth "by" = [ ] [ invalid-question ] if
                            index 2 + index!
                        ] [ invalid-question ] if
                    ] if
                    index tokens length < [ ] [ invalid-question ] if
                    index tokens nth parse-number :> operand
                    result operator operand apply-operation result!
                    index 1 + index!
                ] while
                result
            ] if
        ] if
    ] if ;
