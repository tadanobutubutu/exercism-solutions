proc findAnagrams {subject candidates} {
    set lower [string tolower $subject]
    set sorted [lsort [split $lower ""]]
    set result {}
    foreach c $candidates {
        set clower [string tolower $c]
        if {$clower eq $lower} continue
        if {[lsort [split $clower ""]] eq $sorted} {
            lappend result $c
        }
    }
    return $result
}
