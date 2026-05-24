proc nucleotideCounts {strand} {
    set counts [dict create A 0 C 0 G 0 T 0]
    for {set i 0} {$i < [string length $strand]} {incr i} {
        set char [string index $strand $i]
        if {![dict exists $counts $char]} {
            error "Invalid nucleotide in strand"
        }
        dict incr counts $char
    }
    return $counts
}
