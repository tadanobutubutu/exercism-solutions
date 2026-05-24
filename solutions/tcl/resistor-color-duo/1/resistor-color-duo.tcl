namespace eval ::resistorColor {
    variable colorList {black brown red orange yellow green blue violet grey white}

    proc value {args} {
        variable colorList
        set result 0
        foreach color [lrange $args 0 1] {
            set idx [lsearch -exact $colorList $color]
            if {$idx == -1} {
                error "Invalid color: $color"
            }
            set result [expr {$result * 10 + $idx}]
        }
        return $result
    }
}
