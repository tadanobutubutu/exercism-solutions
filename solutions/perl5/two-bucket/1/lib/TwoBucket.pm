package TwoBucket;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw<measure>;

sub _gcd { my ($a, $b) = @_; $b == 0 ? $a : _gcd($b, $a % $b) }

sub measure {
    my ($size1, $size2, $goal, $start) = @_;

    die "impossible" if $goal > $size1 && $goal > $size2;
    die "impossible" if $goal % _gcd($size1, $size2) != 0;

    my $b1 = $start eq "one" ? $size1 : 0;
    my $b2 = $start eq "two" ? $size2 : 0;
    my @queue = ([$b1, $b2, 1]);
    my %seen;
    $seen{"$b1,$b2"} = 1;

    while (@queue) {
        my ($b1, $b2, $moves) = @{ shift @queue };

        return { goalBucket => "one", moves => $moves, otherBucket => $b2 } if $b1 == $goal;
        return { goalBucket => "two", moves => $moves, otherBucket => $b1 } if $b2 == $goal;

        my @next;

        # fill bucket1
        if ($b1 < $size1) { push @next, [$size1, $b2] }
        # fill bucket2
        if ($b2 < $size2) { push @next, [$b1, $size2] }
        # empty bucket1
        if ($b1 > 0) { push @next, [0, $b2] }
        # empty bucket2
        if ($b2 > 0) { push @next, [$b1, 0] }
        # pour bucket1 into bucket2
        if ($b1 > 0 && $b2 < $size2) {
            my $transfer = $b1 < $size2 - $b2 ? $b1 : $size2 - $b2;
            push @next, [$b1 - $transfer, $b2 + $transfer];
        }
        # pour bucket2 into bucket1
        if ($b2 > 0 && $b1 < $size1) {
            my $transfer = $b2 < $size1 - $b1 ? $b2 : $size1 - $b1;
            push @next, [$b1 + $transfer, $b2 - $transfer];
        }

        for my $state (@next) {
            my ($nb1, $nb2) = @$state;
            my $key = "$nb1,$nb2";
            next if $seen{$key};
            my $start_empty = $start eq "one" ? $nb1 == 0 : $nb2 == 0;
            my $other_full  = $start eq "one" ? $nb2 == $size2 : $nb1 == $size1;
            next if $start_empty && $other_full;
            $seen{$key} = 1;
            push @queue, [$nb1, $nb2, $moves + 1];
        }
    }

    die "impossible";
}

1;
