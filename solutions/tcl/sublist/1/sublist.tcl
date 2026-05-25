proc sublist {list1 list2} {
    if {$list1 eq $list2} {
        return equal
    }
    if {[isSublist $list1 $list2]} {
        return sublist
    }
    if {[isSublist $list2 $list1]} {
        return superlist
    }
    return unequal
}

proc isSublist {a b} {
    set lenA [llength $a]
    set lenB [llength $b]
    if {$lenA > $lenB} {
        return false
    }
    for {set i 0} {$i <= $lenB - $lenA} {incr i} {
        set match true
        for {set j 0} {$j < $lenA} {incr j} {
            if {[lindex $a $j] ne [lindex $b [expr {$i + $j}]]} {
                set match false
                break
            }
        }
        if {$match} {
            return true
        }
    }
    return false
}
