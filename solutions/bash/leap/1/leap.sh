#!/usr/bin/env bash

main () {
    if [[ $# -ne 1 ]] || ! [[ $1 =~ ^[0-9]+$ ]]; then
        echo "Usage: leap.sh <year>"
        exit 1
    fi

    local year=$1

    if (( year % 400 == 0 )); then
        echo "true"
    elif (( year % 100 == 0 )); then
        echo "false"
    elif (( year % 4 == 0 )); then
        echo "true"
    else
        echo "false"
    fi
}

main "$@"
