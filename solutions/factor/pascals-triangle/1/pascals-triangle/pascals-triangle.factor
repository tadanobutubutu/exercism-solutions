USING: arrays grouping kernel math sequences ;
IN: pascals-triangle

: next-row ( row -- row' )
    0 prefix 0 suffix 2 <clumps> [ first2 + ] map ;

:: remaining-rows ( row count -- more )
    count zero? [ { } ] [
        row next-row :> current
        current count 1 - remaining-rows
        current 1array swap append
    ] if ;

: rows ( count -- triangle )
    dup 0 <= [ drop { } ] [
        1 - { 1 } swap remaining-rows
        { 1 } 1array swap append
    ] if ;
