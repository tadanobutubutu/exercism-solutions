package Hamming;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<hamming_distance>;

use Carp qw<croak>;

sub hamming_distance ( $strand1, $strand2 ) {
    croak "strands must be of equal length" if length $strand1 != length $strand2;
    my $distance = 0;
    for my $i (0 .. length($strand1) - 1) {
        $distance++ if substr($strand1, $i, 1) ne substr($strand2, $i, 1);
    }
    return $distance;
}

1;
