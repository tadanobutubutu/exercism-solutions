#!/usr/bin/env bash

main() {
    TZ=UTC perl -MTime::Piece -e '
        my $date = shift;
        $date .= "T00:00:00" if $date =~ /^\d{4}-\d{2}-\d{2}$/;
        my $time = Time::Piece->strptime($date, "%Y-%m-%dT%H:%M:%S");
        my $later = $time + 1_000_000_000;
        print $later->strftime("%Y-%m-%dT%H:%M:%S");
    ' "$1"
}

main "$@"
