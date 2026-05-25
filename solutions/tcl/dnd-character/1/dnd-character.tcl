namespace eval dnd {
    namespace export character ability modifier
    namespace ensemble create

    proc modifier {score} {
        expr {($score - 10) / 2}
    }

    proc ability {} {
        set rolls {}
        for {set i 0} {$i < 4} {incr i} {
            lappend rolls [expr {int(rand() * 6) + 1}]
        }
        set sum 0
        set min 7
        foreach r $rolls {
            incr sum $r
            if {$r < $min} {set min $r}
        }
        expr {$sum - $min}
    }

    proc character {} {
        set c [dict create \
            strength     [ability] \
            dexterity    [ability] \
            constitution [ability] \
            intelligence [ability] \
            wisdom       [ability] \
            charisma     [ability]]
        dict set c hitpoints [expr {10 + [modifier [dict get $c constitution]]}]
        return $c
    }
}
