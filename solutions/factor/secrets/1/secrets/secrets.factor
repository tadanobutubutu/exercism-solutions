USING: kernel locals math math.bitwise ;
IN: secrets

:: shift-back ( value amount -- result )
    value 32 bits amount neg shift ;

: set-bits ( value mask -- result )
    bitor ;

: flip-bits ( value mask -- result )
    bitxor ;

: clear-bits ( value mask -- result )
    bitnot bitand ;
