USING: kernel math sequences ;
IN: series

: series-cannot-be-empty ( -- ) "series cannot be empty" throw ;
: slice-length-cannot-be-zero ( -- ) "slice length cannot be zero" throw ;
: slice-length-cannot-be-negative ( -- ) "slice length cannot be negative" throw ;
: slice-length-cannot-be-greater-than-series-length ( -- )
    "slice length cannot be greater than series length" throw ;

:: slices ( series size -- slices )
    series empty? [ series-cannot-be-empty ] when
    size 0 = [ slice-length-cannot-be-zero ] when
    size 0 < [ slice-length-cannot-be-negative ] when
    size series length > [ slice-length-cannot-be-greater-than-series-length ] when
    series length size - 1 + <iota>
    [| start | start start size + series subseq ] map ;
