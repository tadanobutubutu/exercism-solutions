proc steps {number} {
    if {$number <= 0} {
        error "Only positive integers are allowed"
    }
    set n 0
    while {$number != 1} {
        if {$number % 2 == 0} {
            set number [expr {$number / 2}]
        } else {
            set number [expr {3 * $number + 1}]
        }
        incr n
    }
    return $n
}
