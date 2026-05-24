proc bracketsMatch {input} {
    set stack {}
    for {set i 0} {$i < [string length $input]} {incr i} {
        set char [string index $input $i]
        if {$char eq "(" || $char eq "\[" || $char eq "\{"} {
            lappend stack $char
        } elseif {$char eq ")"} {
            if {[llength $stack] == 0} {return false}
            if {[lindex $stack end] ne "("} {return false}
            set stack [lrange $stack 0 end-1]
        } elseif {$char eq "\]"} {
            if {[llength $stack] == 0} {return false}
            if {[lindex $stack end] ne "\["} {return false}
            set stack [lrange $stack 0 end-1]
        } elseif {$char eq "\}"} {
            if {[llength $stack] == 0} {return false}
            if {[lindex $stack end] ne "\{"} {return false}
            set stack [lrange $stack 0 end-1]
        }
    }
    return [expr {[llength $stack] == 0}]
}
