proc isValid {isbn} {
    set chars [split $isbn ""]
    set digits {}
    set nonDashPos 0
    foreach c $chars {
        if {$c eq "-"} continue
        incr nonDashPos
        if {$c eq "X" || $c eq "x"} {
            lappend digits X
        } elseif {[string is digit $c]} {
            lappend digits $c
        } else {
            return false
        }
    }
    if {[llength $digits] != 10} {
        return false
    }
    set sum 0
    for {set i 0} {$i < 10} {incr i} {
        set d [lindex $digits $i]
        if {$d eq "X"} {
            if {$i != 9} {return false}
            set d 10
        }
        set sum [expr {$sum + $d * (10 - $i)}]
    }
    return [expr {$sum % 11 == 0}]
}
