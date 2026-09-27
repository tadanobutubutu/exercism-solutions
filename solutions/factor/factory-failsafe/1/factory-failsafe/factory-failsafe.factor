USING: continuations kernel math math.order sequences ;
IN: factory-failsafe

ERROR: machine-error ;

! Task 1: Define a machine-error error class.

: check-humidity ( h -- )
    70 > [ "humidity too high" throw ] when ;

: check-temperature ( t -- )
    500 > [ "temperature too high" throw ] when ;

:: monitor ( humidity temperature -- )
    [ humidity check-humidity temperature check-temperature ]
    [ drop machine-error ] recover ;

:: reading-fails? ( reading -- ? )
    reading first 70 > reading second 500 > or ;

: monitor-batch ( readings -- count )
    [ reading-fails? ] count ;
