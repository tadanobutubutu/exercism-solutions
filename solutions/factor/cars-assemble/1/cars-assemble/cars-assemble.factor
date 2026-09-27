USING: combinators kernel locals math ;
IN: cars-assemble

: production-status ( speed -- status )
    zero? [ "stopped" ] [ "running" ] if ;

CONSTANT: base-speed 221

:: success-rate ( speed -- rate )
    {
        { [ speed 0 = ] [ 0.0 ] }
        { [ speed 4 <= ] [ 1.0 ] }
        { [ speed 8 <= ] [ 0.9 ] }
        { [ speed 9 = ] [ 0.8 ] }
        [ 0.77 ]
    } cond ;

: production-rate-per-hour ( speed -- rate )
    dup base-speed * swap success-rate * ;

: working-items-per-minute ( speed -- count )
    production-rate-per-hour 60 /i ;
