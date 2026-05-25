proc luhn {digits} {
    set stripped [string map {{ } {}} $digits]
    if {[string length $stripped] <= 1} {
        return false
    }
    if {![string is digit $stripped]} {
        return false
    }
    set sum 0
    set len [string length $stripped]
    for {set i 0} {$i < $len} {incr i} {
        set d [string index $stripped $i]
        if {$len % 2 == 0} {
            if {$i % 2 == 0} {
                set d [expr {$d * 2}]
                if {$d > 9} {set d [expr {$d - 9}]}
            }
        } else {
            if {$i % 2 == 1} {
                set d [expr {$d * 2}]
                if {$d > 9} {set d [expr {$d - 9}]}
            }
        }
        incr sum $d
    }
    return [expr {$sum % 10 == 0}]
}
