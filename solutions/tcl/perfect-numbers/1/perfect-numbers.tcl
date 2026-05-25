proc classify {n} {
    if {$n < 1} {
        error "Classification is only possible for natural numbers."
    }
    set sum 0
    for {set i 1} {$i <= $n / 2} {incr i} {
        if {$n % $i == 0} {
            incr sum $i
        }
    }
    if {$sum == $n} {
        return perfect
    } elseif {$sum > $n} {
        return abundant
    } else {
        return deficient
    }
}
