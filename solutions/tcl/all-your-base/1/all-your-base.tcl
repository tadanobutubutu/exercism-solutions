proc rebase {inputBase digits outputBase} {
    if {$inputBase < 2} {
        error "input base must be >= 2"
    }
    if {$outputBase < 2} {
        error "output base must be >= 2"
    }
    if {[llength $digits] == 0} {
        return {0}
    }
    set decimal 0
    foreach d $digits {
        if {$d < 0 || $d >= $inputBase} {
            error "all digits must satisfy 0 <= d < input base"
        }
        set decimal [expr {$decimal * $inputBase + $d}]
    }
    if {$decimal == 0} {
        return {0}
    }
    set result {}
    while {$decimal > 0} {
        set result [linsert $result 0 [expr {$decimal % $outputBase}]]
        set decimal [expr {$decimal / $outputBase}]
    }
    return $result
}
