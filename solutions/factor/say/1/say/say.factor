USING: kernel math math.parser sequences strings typed ;
IN: say

CONSTANT: small-words {
    "zero" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine"
    "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen"
    "seventeen" "eighteen" "nineteen"
}

CONSTANT: tens-words {
    "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"
}

:: under-hundred ( n -- words )
    n 20 < [ n small-words nth ] [
        n 10 /i 2 - tens-words nth :> tens
        n 10 mod :> units
        units 0 = [ tens ] [ tens "-" append units small-words nth append ] if
    ] if ;

:: under-thousand ( n -- words )
    n 100 /i :> hundreds
    n 100 mod :> remainder
    hundreds 0 = [ remainder under-hundred ] [
        hundreds small-words nth " hundred" append :> prefix
        remainder 0 = [ prefix ] [ prefix " " append remainder under-hundred append ] if
    ] if ;

:: append-word ( words word -- words' )
    words empty? [ word ] [ words " " append word append ] if ;

TYPED:: say ( n: integer -- str: string )
    n 0 < n 999999999999 > or [ "input out of range" throw ] when
    n 0 = [ "zero" ] [
        "" :> result!
        n 1000000000 /i :> billions
        n 1000000000 mod 1000000 /i :> millions
        n 1000000 mod 1000 /i :> thousands
        n 1000 mod :> ones
        billions 0 > [ result billions under-thousand " billion" append append-word result! ] when
        millions 0 > [ result millions under-thousand " million" append append-word result! ] when
        thousands 0 > [ result thousands under-thousand " thousand" append append-word result! ] when
        ones 0 > [ result ones under-thousand append-word result! ] when
        result
    ] if ;
