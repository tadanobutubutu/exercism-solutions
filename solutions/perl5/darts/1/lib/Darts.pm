package Darts;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<score_dart>;

sub score_dart ( $x, $y ) {
    my $dist = sqrt($x * $x + $y * $y);
    return 10 if $dist <= 1;
    return 5  if $dist <= 5;
    return 1  if $dist <= 10;
    return 0;
}

1;
