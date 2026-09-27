USING: arrays kernel math math.order sequences strings ;
IN: ocr-numbers

CONSTANT: digit-patterns {
    { { " _ " "| |" "|_|" "   " } "0" }
    { { "   " "  |" "  |" "   " } "1" }
    { { " _ " " _|" "|_ " "   " } "2" }
    { { " _ " " _|" " _|" "   " } "3" }
    { { "   " "|_|" "  |" "   " } "4" }
    { { " _ " "|_ " " _|" "   " } "5" }
    { { " _ " "|_ " "|_|" "   " } "6" }
    { { " _ " "  |" "  |" "   " } "7" }
    { { " _ " "|_|" "|_|" "   " } "8" }
    { { " _ " "|_|" " _|" "   " } "9" }
}

:: convert-digit ( rows row-start col-start -- digit )
    4 <iota> [| offset |
        row-start offset + rows nth :> line
        col-start col-start 3 + line subseq
    ] { } map-as :> segments
    digit-patterns [| pattern | pattern first segments = ] find nip :> found
    found f = [ "?" ] [ found second ] if ;

:: convert ( rows -- str )
    rows length 4 mod 0 = [ ] [
        "Number of input lines is not a multiple of four" throw
    ] if
    rows empty? [ "" ] [
        rows first length :> width
        width 3 mod 0 = [ ] [
            "Number of input columns is not a multiple of three" throw
        ] if
        rows length 4 /i <iota> [| group |
            width 3 /i <iota> [| digit |
                rows group 4 * digit 3 * convert-digit
            ] { } map-as "" join
        ] { } map-as "," join
    ] if ;
