USING: kernel locals math math.functions math.order ;
IN: currency-conversion

: exchange-money ( budget exchange-rate -- exchanged )
    /f ;

: get-change ( budget exchanging-value -- change )
    - ;

: value-of-bills ( denomination number-of-bills -- value )
    * ;

: number-of-bills ( amount denomination -- bills )
    /i ;

:: leftover-of-bills ( amount denomination -- leftover )
    amount amount denomination /i denomination * - ;

:: exchangeable-value ( denomination budget spread exchange-rate -- value )
    spread 100 /f 1.0 + exchange-rate * :> total-rate
    budget total-rate /f denomination /f floor >integer
    denomination * ;

: safe-change ( budget exchanging-value -- change )
    - 0 max ;

: cap-spend ( budget price -- spend )
    min ;
