proc diamond {letter} {
    set letters {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z}
    set idx [lsearch $letters $letter]
    set width [expr {2 * $idx + 1}]
    set lines {}
    for {set i 0} {$i <= $idx} {incr i} {
        set ch [lindex $letters $i]
        if {$i == 0} {
            set left [expr {($width - 1) / 2}]
            lappend lines "[string repeat " " $left]$ch[string repeat " " $left]"
        } else {
            set inner [expr {2 * $i - 1}]
            set left [expr {($width - $inner - 2) / 2}]
            lappend lines "[string repeat " " $left]$ch[string repeat " " $inner]$ch[string repeat " " $left]"
        }
    }
    for {set i [expr {$idx - 1}]} {$i >= 0} {incr i -1} {
        set ch [lindex $letters $i]
        if {$i == 0} {
            set left [expr {($width - 1) / 2}]
            lappend lines "[string repeat " " $left]$ch[string repeat " " $left]"
        } else {
            set inner [expr {2 * $i - 1}]
            set left [expr {($width - $inner - 2) / 2}]
            lappend lines "[string repeat " " $left]$ch[string repeat " " $inner]$ch[string repeat " " $left]"
        }
    }
    return [join $lines \n]
}
