proc keep {varname list condition} {
    set result {}
    foreach item $list {
        upvar 1 $varname var
        set var $item
        if {[uplevel 1 $condition]} {
            lappend result $item
        }
    }
    return $result
}

proc discard {varname list condition} {
    set result {}
    foreach item $list {
        upvar 1 $varname var
        set var $item
        if {![uplevel 1 $condition]} {
            lappend result $item
        }
    }
    return $result
}
