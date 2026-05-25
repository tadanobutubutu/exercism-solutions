proc heyBob {input} {
    set trimmed [string trim $input]
    if {$trimmed eq ""} {
        return "Fine. Be that way!"
    }
    set hasLetters [regexp {[A-Za-z]} $trimmed]
    set isShouting [expr {$hasLetters && $trimmed eq [string toupper $trimmed]}]
    set isQuestion [expr {[string index $trimmed end] eq "?"}]
    if {$isShouting && $isQuestion} {
        return "Calm down, I know what I'm doing!"
    }
    if {$isShouting} {
        return "Whoa, chill out!"
    }
    if {$isQuestion} {
        return "Sure."
    }
    return "Whatever."
}
