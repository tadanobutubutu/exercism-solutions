USING: accessors kernel math math.functions math.statistics random sequences sorting ;
IN: dnd-character

TUPLE: character
    strength dexterity constitution intelligence wisdom charisma
    hitpoints ;

:: modifier ( score -- n )
    score 10 - 2 / floor ;

: ability ( -- score )
    4 [ { 1 2 3 4 5 6 } random ] replicate sort 1 tail sum ;

: <character> ( -- character )
    character new
    ability >>strength
    ability >>dexterity
    ability >>constitution
    ability >>intelligence
    ability >>wisdom
    ability >>charisma
    dup constitution>> modifier 10 + >>hitpoints ;
