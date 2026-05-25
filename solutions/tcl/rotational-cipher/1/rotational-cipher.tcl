proc rotate {text shift} {
    set result ""
    foreach c [split $text ""] {
        if {$c >= "a" && $c <= "z"} {
            set code [expr {(([scan $c %c] - 97 + $shift) % 26) + 97}]
            append result [format %c $code]
        } elseif {$c >= "A" && $c <= "Z"} {
            set code [expr {(([scan $c %c] - 65 + $shift) % 26) + 65}]
            append result [format %c $code]
        } else {
            append result $c
        }
    }
    return $result
}
