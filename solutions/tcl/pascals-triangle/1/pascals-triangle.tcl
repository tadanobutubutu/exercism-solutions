proc triangle {n} {
    set result {}
    for {set row 0} {$row < $n} {incr row} {
        set r {}
        set val 1
        for {set col 0} {$col <= $row} {incr col} {
            lappend r $val
            set val [expr {$val * ($row - $col) / ($col + 1)}]
        }
        lappend result $r
    }
    return $result
}
