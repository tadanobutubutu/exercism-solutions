proc factors {n} {
    set result {}
    set d 2
    while {$d * $d <= $n} {
        while {$n % $d == 0} {
            lappend result $d
            set n [expr {$n / $d}]
        }
        incr d
    }
    if {$n > 1} {
        lappend result $n
    }
    return $result
}
