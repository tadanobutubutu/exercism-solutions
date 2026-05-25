proc abbreviate {phrase} {
    set result {}
    set words [regexp -all -inline {[A-Za-z']+} $phrase]
    foreach word $words {
        append result [string toupper [string index $word 0]]
    }
    return $result
}
