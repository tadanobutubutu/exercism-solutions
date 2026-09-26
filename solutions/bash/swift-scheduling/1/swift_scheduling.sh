#!/usr/bin/env bash

# The following comments should help you get started:
# - Bash is flexible. You may use functions or write a "raw" script.
#
# - Complex code can be made easier to read by breaking it up
#   into functions, however this is sometimes overkill in bash.
#
# - You can find links about good style and other resources
#   for Bash in './README.md'. It came with this exercise.
#
#   Example:
#   # other functions here
#   # ...
#   # ...
#
#   main () {
#     # your main function code here
#   }
#
#   # call main with all of the positional arguments
#   main "$@"
#
# *** PLEASE REMOVE THESE COMMENTS BEFORE SUBMITTING YOUR SOLUTION ***
#!/usr/bin/env bash

TZ=UTC perl -MTime::Piece -MTime::Seconds -e '
    my ($description, $start) = @ARGV;
    my $time = Time::Piece->strptime($start, "%Y-%m-%dT%H:%M:%S");
    my $result;
    if ($description eq "NOW") {
        $result = $time + 7200;
    } elsif ($description eq "ASAP") {
        if ($time->hour < 13) {
            $result = Time::Piece->strptime($time->strftime("%Y-%m-%d") . "T17:00:00", "%Y-%m-%dT%H:%M:%S");
        } else {
            $time = $time + 86400;
            $result = Time::Piece->strptime($time->strftime("%Y-%m-%d") . "T13:00:00", "%Y-%m-%dT%H:%M:%S");
        }
    } elsif ($description eq "EOW") {
        my $weekday = $time->wday;
        if ($weekday >= 2 && $weekday <= 4) {
            $time = $time + (6 - $weekday) * 86400;
            $result = Time::Piece->strptime($time->strftime("%Y-%m-%d") . "T17:00:00", "%Y-%m-%dT%H:%M:%S");
        } else {
            my $days = $weekday == 5 ? 3 : $weekday == 6 ? 2 : $weekday == 7 ? 1 : 5;
            $time = $time + $days * 86400;
            $result = Time::Piece->strptime($time->strftime("%Y-%m-%d") . "T20:00:00", "%Y-%m-%dT%H:%M:%S");
        }
    } elsif ($description =~ /^(\d+)M$/ && $1 >= 1 && $1 <= 12) {
        my $month = $1;
        my $year = $time->year + ($time->mon >= $month ? 1 : 0);
        $result = Time::Piece->strptime(sprintf("%04d-%02d-01T08:00:00", $year, $month), "%Y-%m-%dT%H:%M:%S");
        while ($result->wday == 1 || $result->wday == 7) { $result = $result + 86400; }
    } elsif ($description =~ /^Q([1-4])$/) {
        my $quarter = $1;
        my $current_quarter = int(($time->mon - 1) / 3) + 1;
        my $year = $time->year + ($current_quarter > $quarter ? 1 : 0);
        my $month = $quarter * 3;
        my $next_month = $month == 12 ? 1 : $month + 1;
        my $next_year = $month == 12 ? $year + 1 : $year;
        $result = Time::Piece->strptime(sprintf("%04d-%02d-01T08:00:00", $next_year, $next_month), "%Y-%m-%dT%H:%M:%S") - 86400;
        $result = Time::Piece->strptime($result->strftime("%Y-%m-%d") . "T08:00:00", "%Y-%m-%dT%H:%M:%S");
        while ($result->wday == 1 || $result->wday == 7) { $result = $result - 86400; }
    } else { die "invalid delivery date description\n"; }
    print $result->strftime("%Y-%m-%dT%H:%M:%S");
' "$@"
