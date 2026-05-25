proc transpose {lines} {
    set maxlen 0
    foreach line $lines {
        set len [string length $line]
        if {$len > $maxlen} {
            set maxlen $len
        }
    }
    set result {}
    for {set col 0} {$col < $maxlen} {incr col} {
        set rowChars {}
        foreach line $lines {
            if {$col < [string length $line]} {
                lappend rowChars [string index $line $col]
            } else {
                lappend rowChars " "
            }
        }
        set nLines [llength $lines]
        set keepEnd [expr {$nLines - 1}]
        while {$keepEnd >= 0} {
            set thisLineLen [string length [lindex $lines $keepEnd]]
            if {$col < $thisLineLen} {
                break
            }
            incr keepEnd -1
        }
        if {$keepEnd < 0} {
            lappend result ""
        } else {
            set row [join [lrange $rowChars 0 $keepEnd] ""]
            lappend result $row
        }
    }
    return $result
}
