proc slices {series length} {
    set slen [string length $series]
    if {$slen == 0} {
        error "series cannot be empty"
    }
    if {$length <= 0} {
        error "slice length cannot be less than one"
    }
    if {$length > $slen} {
        error "slice length cannot be greater than series length"
    }
    set result {}
    for {set i 0} {$i <= $slen - $length} {incr i} {
        lappend result [string range $series $i [expr {$i + $length - 1}]]
    }
    return $result
}
