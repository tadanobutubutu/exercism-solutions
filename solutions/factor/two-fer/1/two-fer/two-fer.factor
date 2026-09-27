USING: kernel sequences ;
IN: two-fer

! There are no variadic functions in Factor, due to the nature of the stack.

: 2-for-1 ( name -- str )
    dup
    [ "One for " swap append ", one for me." append ]
    [ drop "One for you, one for me." ]
    if ;
