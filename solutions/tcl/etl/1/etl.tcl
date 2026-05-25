proc transform {input} {
    set result {}
    if {[llength $input] % 2 != 0} {
        error "invalid input"
    }
    foreach {score letters} $input {
        foreach letter $letters {
            dict set result [string tolower $letter] $score
        }
    }
    return $result
}
