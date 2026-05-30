#!/usr/bin/env bash

main() {
    local date="$1"
    date -u -d "$date + 1000000000 seconds" +"%Y-%m-%dT%H:%M:%S"
}

main "$@"
