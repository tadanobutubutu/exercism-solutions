#!/usr/bin/env bash

main () {
    local planet=$1 seconds=$2

    case "$planet" in
        Earth)   local period=1.0 ;;
        Mercury) local period=0.2408467 ;;
        Venus)   local period=0.61519726 ;;
        Mars)    local period=1.8808158 ;;
        Jupiter) local period=11.862615 ;;
        Saturn)  local period=29.447498 ;;
        Uranus)  local period=84.016846 ;;
        Neptune) local period=164.79132 ;;
        *)       echo "not a planet"; exit 1 ;;
    esac

    local earth_years
    earth_years=$(echo "scale=14; $seconds / 31557600" | bc)
    local age
    age=$(echo "scale=14; $earth_years / $period" | bc)
    printf "%.2f\n" "$age"
}

main "$@"
