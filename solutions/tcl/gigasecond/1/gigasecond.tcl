proc addGigasecond {datetime} {
    set timestamp [clock scan $datetime]
    set newtime [expr {$timestamp + 1000000000}]
    return [clock format $newtime -format "%Y-%m-%dT%H:%M:%S"]
}
