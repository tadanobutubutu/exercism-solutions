proc score {x y} {
    set dist [expr {sqrt($x * $x + $y * $y)}]
    if {$dist <= 1} {return 10}
    if {$dist <= 5} {return 5}
    if {$dist <= 10} {return 1}
    return 0
}
