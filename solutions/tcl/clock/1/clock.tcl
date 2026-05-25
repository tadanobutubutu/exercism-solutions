oo::class create Clock {
    variable totalMinutes

    constructor {hour minute} {
        set totalMinutes [expr {($hour * 60 + $minute) % (24 * 60)}]
        if {$totalMinutes < 0} {
            set totalMinutes [expr {$totalMinutes + 24 * 60}]
    method == {other} {
        expr {[my toString] eq [$other toString]}
    }
}
    }

    method toString {} {
        set h [expr {$totalMinutes / 60}]
        set m [expr {$totalMinutes % 60}]
        format %02d:%02d $h $m
    }

    method add {minutes} {
        Clock new 0 [expr {$totalMinutes + $minutes}]
    }

    method subtract {minutes} {
        Clock new 0 [expr {$totalMinutes - $minutes}]
    }

    method equals {other} {
        expr {[my toString] eq [$other toString]}
    }

}
