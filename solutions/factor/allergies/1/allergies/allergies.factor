USING: assocs hash-sets kernel math sequences ;
IN: allergies

CONSTANT: allergen-values {
    { "eggs" 1 }
    { "peanuts" 2 }
    { "shellfish" 4 }
    { "strawberries" 8 }
    { "tomatoes" 16 }
    { "chocolate" 32 }
    { "pollen" 64 }
    { "cats" 128 }
}

:: allergens ( score -- set )
    allergen-values
        [| pair | score pair second bitand 0 > ] filter
        [ first ] map >hash-set ;

:: allergic-to ( score item -- ? )
    allergen-values [| pair | pair first item = ] find nip :> pair
    pair [ score pair second bitand 0 > ] [ f ] if ;
