proc onEarth {seconds} {
    expr {$seconds / 31557600.0}
}

proc onMercury {seconds} {
    expr {[onEarth $seconds] / 0.2408467}
}

proc onVenus {seconds} {
    expr {[onEarth $seconds] / 0.61519726}
}

proc onMars {seconds} {
    expr {[onEarth $seconds] / 1.8808158}
}

proc onJupiter {seconds} {
    expr {[onEarth $seconds] / 11.862615}
}

proc onSaturn {seconds} {
    expr {[onEarth $seconds] / 29.447498}
}

proc onUranus {seconds} {
    expr {[onEarth $seconds] / 84.016846}
}

proc onNeptune {seconds} {
    expr {[onEarth $seconds] / 164.79132}
}

proc onSun {args} {
    error "not a planet"
}
