proc hammingDistance {left right} {
    if {[string length $left] != [string length $right]} {
        error "strands must be of equal length"
    }
    set dist 0
    for {set i 0} {$i < [string length $left]} {incr i} {
        if {[string index $left $i] ne [string index $right $i]} {
            incr dist
        }
    }
    return $dist
}
