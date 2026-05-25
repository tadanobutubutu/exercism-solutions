proc recite {items} {
    set n [llength $items]
    if {$n == 0} {
        return {}
    }
    set result {}
    for {set i 0} {$i < $n - 1} {incr i} {
        lappend result "For want of a [lindex $items $i] the [lindex $items [expr {$i + 1}]] was lost."
    }
    lappend result "And all for the want of a [lindex $items 0]."
    return $result
}
