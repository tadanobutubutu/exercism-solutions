proc squareOfSum {n} {
    set sum [expr {$n * ($n + 1) / 2}]
    return [expr {$sum * $sum}]
}

proc sumOfSquares {n} {
    return [expr {$n * ($n + 1) * (2 * $n + 1) / 6}]
}

proc differenceOfSquares {n} {
    return [expr {[squareOfSum $n] - [sumOfSquares $n]}]
}
