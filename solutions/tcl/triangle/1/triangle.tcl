namespace eval triangle {
    proc is {kind sides} {
        lassign $sides a b c
        if {$a <= 0 || $b <= 0 || $c <= 0} {return false}
        if {$a + $b <= $c || $a + $c <= $b || $b + $c <= $a} {return false}
        switch $kind {
            equilateral { expr {$a == $b && $b == $c} }
            isosceles   { expr {$a == $b || $b == $c || $a == $c} }
            scalene     { expr {$a != $b && $b != $c && $a != $c} }
            default     { error "unknown kind" }
        }
    }
}
