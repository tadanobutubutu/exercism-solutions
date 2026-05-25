proc isIsogram {input} {
    set seen {}
    for {set i 0} {$i < [string length $input]} {incr i} {
        set char [string tolower [string index $input $i]]
        if {$char eq "-" || $char eq " "} {continue}
        if {[dict exists $seen $char]} {return false}
        dict set seen $char 1
    }
    return true
}
