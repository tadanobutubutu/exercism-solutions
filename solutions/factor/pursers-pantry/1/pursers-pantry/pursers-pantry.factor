USING: assocs kernel math math.order sequences sorting ;
IN: pursers-pantry

:: create-inventory ( items -- inventory )
    H{ } clone :> inventory
    items [| item | item inventory inc-at ] each
    inventory ;

:: add-items ( inventory items -- inventory' )
    inventory clone :> updated
    items [| item | item updated inc-at ] each
    updated ;

:: decrement-items ( inventory items -- inventory' )
    inventory clone :> updated
    items [| item |
        item updated at dup [ 1 - 0 max item updated set-at ] [ drop ] if
    ] each
    updated ;

:: remove-item ( inventory item -- inventory' )
    inventory clone :> updated
    item updated key? [ item updated delete-at ] when
    updated ;

:: list-inventory ( inventory -- items )
    inventory sort-keys [ second 0 > ] filter ;
