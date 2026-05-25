proc sumOfMultiples {factors limit} {
    array unset results
    foreach f $factors {
        if {$f == 0} continue
        for {set i $f} {$i < $limit} {incr i $f} {
            set results($i) 1
        }
    }
    set sum 0
    foreach n [array names results] {
        incr sum $n
    }
    return $sum
}
