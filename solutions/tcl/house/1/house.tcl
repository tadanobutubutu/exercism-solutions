proc recite {from to} {
    set pieces {
        "the house that Jack built."
        "the malt that lay in"
        "the rat that ate"
        "the cat that killed"
        "the dog that worried"
        "the cow with the crumpled horn that tossed"
        "the maiden all forlorn that milked"
        "the man all tattered and torn that kissed"
        "the priest all shaven and shorn that married"
        "the rooster that crowed in the morn that woke"
        "the farmer sowing his corn that kept"
        "the horse and the hound and the horn that belonged to"
    }
    set result {}
    for {set i $from} {$i <= $to} {incr i} {
        set verse "This is "
        for {set j [expr {$i - 1}]} {$j >= 0} {incr j -1} {
            append verse [lindex $pieces $j]
            if {$j > 0} {
                append verse " "
            }
        }
        lappend result $verse
    }
    return [join $result \n]
}
