namespace eval ::resistorColor {
    proc label {args} {
        set colorList {black brown red orange yellow green blue violet grey white}
        set value 0
        foreach c [lrange $args 0 1] {
            set idx [lsearch $colorList $c]
            if {$idx < 0} {error "invalid color: $c"}
            set value [expr {$value * 10 + $idx}]
        }
        set zeros [lsearch $colorList [lindex $args 2]]
        if {$zeros < 0} {error "invalid color: [lindex $args 2]"}
        set value [expr {$value * int(pow(10, $zeros))}]
        if {$value >= 1000000000 && $value % 1000000000 == 0} {
            return "[expr {$value / 1000000000}] gigaohms"
        } elseif {$value >= 1000000 && $value % 1000000 == 0} {
            return "[expr {$value / 1000000}] megaohms"
        } elseif {$value >= 1000 && $value % 1000 == 0} {
            return "[expr {$value / 1000}] kiloohms"
        } else {
            return "$value ohms"
        }
    }
}
