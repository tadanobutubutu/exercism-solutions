namespace eval atbash {
    namespace export encode decode
    namespace ensemble create

    proc encode {text} {
        set result {}
        set count 0
        foreach c [split [string tolower $text] ""] {
            if {$c >= "a" && $c <= "z"} {
                set code [expr {219 - [scan $c %c]}]
                append result [format %c $code]
                incr count
                if {$count % 5 == 0} {
                    append result " "
                }
            } elseif {$c >= "0" && $c <= "9"} {
                append result $c
                incr count
                if {$count % 5 == 0} {
                    append result " "
                }
            }
        }
        return [string trimright $result]
    }

    proc decode {text} {
        set result {}
        set clean [string map {{ } {}} $text]
        foreach c [split $clean ""] {
            if {$c >= "a" && $c <= "z"} {
                set code [expr {219 - [scan $c %c]}]
                append result [format %c $code]
            } else {
                append result $c
            }
        }
        return $result
    }
}
