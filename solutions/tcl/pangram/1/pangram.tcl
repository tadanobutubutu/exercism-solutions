proc isPangram {text} {
    set letters {}
    for {set i 0} {$i < [string length $text]} {incr i} {
        set char [string tolower [string index $text $i]]
        if {$char ge "a" && $char le "z"} {
            dict set letters $char 1
        }
    }
    return [expr {[dict size $letters] == 26}]
}
