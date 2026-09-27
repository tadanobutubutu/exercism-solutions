USING: accessors arrays assocs kernel locals sequences sorting ;
IN: grade-school

! Define a `school` tuple to hold the roster, then implement the
! words below.

TUPLE: school students ;

:: <school> ( -- school )
    H{ } clone school boa ;

:: add-student ( school name grade -- ? )
    name school students>> key? [
        f
    ] [
        grade name school students>> set-at
        t
    ] if ;

:: roster ( school -- names )
    V{ } clone :> entries
    school students>> [| name student-grade |
        student-grade name 2array entries push
    ] assoc-each
    entries sort [ second ] map ;

:: grade ( school n -- names )
    V{ } clone :> names
    school students>> [| name student-grade |
        student-grade n = [ name names push ] when
    ] assoc-each
    names sort ;
