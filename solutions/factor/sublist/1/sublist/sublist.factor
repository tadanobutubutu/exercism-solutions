USING: kernel math sequences ;
IN: sublist

SYMBOLS: equal sublist superlist unequal ;

:: contains-contiguous? ( needle haystack -- ? )
    needle empty? [
        t
    ] [
        needle length haystack length <= [
            haystack length needle length - 1 + <iota>
            [| start | start start needle length + haystack subseq needle = ] any?
        ] [
            f
        ] if
    ] if ;

:: relation ( list-one list-two -- result )
    list-one list-two = [
        equal
    ] [
        list-one list-two contains-contiguous? [
            sublist
        ] [
            list-two list-one contains-contiguous? [ superlist ] [ unequal ] if
        ] if
    ] if ;
