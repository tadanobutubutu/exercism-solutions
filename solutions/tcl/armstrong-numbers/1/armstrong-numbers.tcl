proc isArmstrongNumber {number} {
    set digits [split $number ""]
    set n [llength $digits]
    set sum 0
    foreach d $digits {
        set sum [expr {$sum + $d ** $n}]
    }
    return [expr {$sum == $number}]
}
