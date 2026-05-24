proc formatTicket {name number} {
    if {$number % 100 >= 11 && $number % 100 <= 13} {
        set suffix "th"
    } else {
        switch -- [expr {$number % 10}] {
            1 { set suffix "st" }
            2 { set suffix "nd" }
            3 { set suffix "rd" }
            default { set suffix "th" }
        }
    }
    return "$name, you are the ${number}${suffix} customer we serve today. Thank you!"
}
