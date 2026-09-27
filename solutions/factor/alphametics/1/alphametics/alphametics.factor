USING: accessors arrays assocs hash-sets hashtables kernel math
sequences sets ;
USING: splitting ;
IN: alphametics

TUPLE: puzzle-state addends result letter-index leading column-counts ;

:: add-column-letter ( word col counts -- )
    word length col - 1 - word nth :> letter
    letter counts at* [ 1 + ] [ drop 1 ] if :> frequency
    frequency letter counts set-at ;

:: make-column-counts ( addends col -- counts )
    H{ } clone :> counts
    addends [| word |
        word length col > [
            word col counts add-column-letter
        ] when
    ] each
    counts ;

:: search-columns ( state col carry assignments used position total -- solution/f )
    col state result>> length >= [
        carry zero? [ assignments ] [ f ] if
    ] [
        col state column-counts>> nth :> counts
        counts keys :> terms
        position terms length >= [
            total carry + :> sum
            sum 10 mod :> required
            sum 10 /i :> next-carry
            state result>> length col - 1 - state result>> nth :> result-letter
            result-letter state letter-index>> at :> idx
            idx assignments nth :> digit
            digit 0 >= [
                digit required = [
                    state col 1 + next-carry assignments used 0 0 search-columns
                ] [ f ] if
            ] [
                required 0 = result-letter state leading>> in? and
                used 1 required shift bitand zero? not or [
                    f
                ] [
                    assignments clone :> next-assignments
                    required idx next-assignments set-nth
                    used 1 required shift bitor :> next-used
                    state col 1 + next-carry next-assignments next-used 0 0 search-columns
                ] if
            ] if
        ] [
            position terms nth :> letter
            letter state letter-index>> at :> idx
            letter counts at :> frequency
            idx assignments nth :> digit
            digit 0 >= [
                state col carry assignments used position 1 +
                    total digit frequency * + search-columns
            ] [
                f :> found!
                10 <iota> [| candidate |
                    found not [
                        candidate 0 = letter state leading>> in? and not
                        used 1 candidate shift bitand zero? and [
                            assignments clone :> next-assignments
                            candidate idx next-assignments set-nth
                            used 1 candidate shift bitor :> next-used
                            state col carry next-assignments next-used position 1 +
                                total candidate frequency * + search-columns :> trial
                            trial [ trial found! ] when
                        ] when
                    ] when
                ] each
                found
            ] if
        ] if
    ] if ;

:: solve ( puzzle -- mapping/f )
    puzzle " " split :> tokens
    tokens [ "==" = ] find drop :> equals-index
    0 equals-index tokens <slice> [ "+" = not ] filter :> addends
    equals-index 1 + tokens nth :> result
    addends [| word | word length result length > ] any? [
        f
    ] [
        HS{ } clone :> letter-set
        addends [| word | word [| letter | letter letter-set adjoin ] each ] each
        result [| letter | letter letter-set adjoin ] each
        letter-set cardinality 10 > [
            f
        ] [
            HS{ } clone :> leading
            addends [| word | word length 1 > [ word first leading adjoin ] when ] each
            result length 1 > [ result first leading adjoin ] when
            letter-set members :> letters
            H{ } clone :> letter-index
            letters length <iota> [| i |
                i letters nth :> letter
                i letter letter-index set-at
            ] each
            result length <iota> [| col |
                addends col make-column-counts
            ] map >array :> column-counts
            puzzle-state new
                addends >>addends
                result >>result
                letter-index >>letter-index
                leading >>leading
                column-counts >>column-counts :> state
            letters length [ -1 ] replicate >array :> assignments
            state 0 0 assignments 0 0 0 search-columns :> solution
            solution [
                H{ } clone :> answer
                letters length <iota> [| i |
                    i letters nth :> letter
                    i solution nth :> digit
                    digit letter answer set-at
                ] each
                answer
            ] [ f ] if
        ] if
    ] if ;
