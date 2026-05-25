proc meetup {args} {
    lassign $args year month descriptor dayname

    set days {Sunday Monday Tuesday Wednesday Thursday Friday Saturday}
    set targetDay [lsearch $days $dayname]
    if {$targetDay < 0} {error "invalid day: $dayname"}

    set date [clock scan "$year-$month-01" -format {%Y-%m-%d}]
    set firstDayOfMonth [clock format $date -format {%w}]
    set firstOfDay [expr {($targetDay - $firstDayOfMonth + 7) % 7 + 1}]

    switch -- $descriptor {
        teenth {
            set day $firstOfDay
            while {$day < 13} {
                incr day 7
            }
        }
        first { set day $firstOfDay }
        second { set day [expr {$firstOfDay + 7}] }
        third { set day [expr {$firstOfDay + 14}] }
        fourth { set day [expr {$firstOfDay + 21}] }
        last {
            if {$month == 12} {
                set nextMonth [clock scan "[expr {$year + 1}]-01-01" -format {%Y-%m-%d}]
            } else {
                set nextMonth [clock scan "$year-[expr {$month + 1}]-01" -format {%Y-%m-%d}]
            }
            set lastDay [clock add $nextMonth -1 day]
            set lastDayOfMonth [clock format $lastDay -format {%d}]
            set lastOfDay [expr {$lastDayOfMonth - ($lastDayOfMonth - $firstOfDay) % 7}]
            while {$lastOfDay > $lastDayOfMonth} {
                set lastOfDay [expr {$lastOfDay - 7}]
            }
            set day $lastOfDay
        }
    }

    return [format %04d-%02d-%02d $year $month $day]
}
