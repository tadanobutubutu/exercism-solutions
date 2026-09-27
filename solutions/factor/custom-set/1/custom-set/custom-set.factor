USING: accessors hash-sets kernel sequences sets ;
IN: custom-set

! Define a `custom-set` tuple and declare it an instance of the
! `set` mixin with `INSTANCE: custom-set set`.

! Add `M: custom-set` methods for `members`, `in?`, `adjoin`,
! and `set-like` so that `null?`, `union`, `intersect`, `diff`,
! `subset?`, `set=`, and `intersects?` from the `sets` vocab work
! on your set automatically.

TUPLE: custom-set contents ;

INSTANCE: custom-set set

: <custom-set> ( -- set )
    custom-set new HS{ } clone >>contents ;

:: >custom-set ( seq -- set )
    <custom-set> :> set
    seq [| elt | elt set adjoin ] each
    set ;

M: custom-set members contents>> members ;
M: custom-set in? contents>> in? ;
M: custom-set adjoin contents>> adjoin ;
M: custom-set set-like drop >custom-set ;
