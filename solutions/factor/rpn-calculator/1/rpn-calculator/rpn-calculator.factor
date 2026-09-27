USING: assocs kernel locals math sequences ;
IN: rpn-calculator

ERROR: zero-divisor-error ;

:: add-op ( stack -- new-stack )
    stack 2 head* :> prefix
    prefix stack last2 + suffix ;

:: multiply-op ( stack -- new-stack )
    stack 2 head* :> prefix
    prefix stack last2 * suffix ;

: apply-op ( stack op -- new-stack )
    call( stack -- new-stack ) ;

:: evaluate ( stack ops -- final-stack )
    stack :> state!
    ops [| op | state op apply-op state! ] each
    state ;

:: evaluate-named ( stack ops names -- final-stack )
    names [| name | name ops at ] map stack swap evaluate ;

:: divide-op ( stack -- new-stack )
    stack last zero? [ zero-divisor-error ] when
    stack 2 head* :> prefix
    prefix stack last2 /i suffix ;
