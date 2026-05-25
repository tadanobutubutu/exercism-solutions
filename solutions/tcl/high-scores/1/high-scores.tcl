oo::class create HighScores {
    variable scoreList

    constructor {} {
        set scoreList {}
    }

    method addScores {args} {
        lappend scoreList {*}$args
    }

    method scores {} {
        return $scoreList
    }

    method latest {} {
        if {[llength $scoreList] == 0} {
            return {}
        }
        return [lindex $scoreList end]
    }

    method personalBest {} {
        if {[llength $scoreList] == 0} {
            return {}
        }
        return [lindex [lsort -integer -decreasing $scoreList] 0]
    }

    method topThree {} {
        set sorted [lsort -integer -decreasing $scoreList]
        return [lrange $sorted 0 2]
    }
}
