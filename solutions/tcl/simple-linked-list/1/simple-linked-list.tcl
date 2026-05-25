oo::class create Node {
    variable datum
    variable next

    constructor {value} {
        set datum $value
        set next {}
    }

    method datum {} {
        return $datum
    }

    method next {args} {
        if {[llength $args] == 0} {
            return $next
        }
        set next [lindex $args 0]
        return $next
    }
}

oo::class create SimpleLinkedList {
    variable head

    constructor {{values {}}} {
        set head {}
        foreach v $values {
            my push [Node new $v]
        }
    }

    method push {node} {
        $node next $head
        set head $node
        return [self]
    }

    method pop {} {
        if {$head eq {}} {
            return {}
        }
        set node $head
        set head [$head next]
        return $node
    }

    method foreach {var body} {
        set current $head
        while {$current ne {}} {
            uplevel 1 [list set $var $current]
            uplevel 1 $body
            set current [$current next]
        }
    }

    method toList {} {
        set result {}
        set current $head
        while {$current ne {}} {
            lappend result [$current datum]
            set current [$current next]
        }
        return $result
    }

    method reverse {} {
        set prev {}
        set current $head
        while {$current ne {}} {
            set next [$current next]
            $current next $prev
            set prev $current
            set current $next
        }
        set head $prev
        return [self]
    }
}
