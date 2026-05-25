package PythagoreanTriplet;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw<triplets_with_sum>;

sub triplets_with_sum {
    my $n = shift;
    my @triplets;
    for my $a (1 .. $n / 3) {
        for my $b ($a + 1 .. ($n - $a) / 2) {
            my $c = $n - $a - $b;
            push @triplets, [$a, $b, $c] if $a**2 + $b**2 == $c**2;
        }
    }
    \@triplets;
}

1;
