USING: accessors arrays kernel math sequences vectors ;
IN: simple-linked-list

ERROR: list-empty ;

TUPLE: linked-list-node value next ;
TUPLE: linked-list head count ;

! Define `linked-list-node` and `linked-list` tuples, then implement
! these words. Also add `M: linked-list length` (from `sequences`) so
! the tests can call `length` on your list.

: <linked-list> ( -- linked-list )
    linked-list new f >>head 0 >>count ;

:: linked-list>array ( list -- array )
    V{ } clone :> values
    list head>> :> current!
    [ current ] [
        current value>> values push
        current next>> current!
    ] while
    values >array ;

:: list-push ( list value -- linked-list )
    linked-list-node new value >>value list head>> >>next :> node
    list node >>head drop
    list dup count>> 1 + >>count ;

:: >linked-list ( seq -- linked-list )
    <linked-list> :> list
    seq [| value | list value list-push drop ] each
    list ;

:: list-pop ( list -- linked-list value )
    list head>> [ ] [ list-empty ] if
    list head>> :> node
    list node next>> >>head drop
    list dup count>> 1 - >>count
    node value>> ;

:: list-peek ( list -- value )
    list head>> :> node
    node [ node value>> ] [ list-empty ] if ;

M: linked-list length count>> ;

:: list-reverse ( list -- linked-list )
    f :> previous!
    list head>> :> current!
    [ current ] [
        current next>> :> next
        current previous >>next drop
        current previous!
        next current!
    ] while
    list previous >>head ;
