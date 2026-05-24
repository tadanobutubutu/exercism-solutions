namespace eval resistorColor {
    variable colorList {black brown red orange yellow green blue violet grey white}

    proc colorCode {color} {
        variable colorList
        set idx [lsearch -exact $colorList $color]
        if {$idx == -1} {
            error "Invalid color: $color"
        }
        return $idx
    }

    proc colors {} {
        variable colorList
        return $colorList
    }
}
