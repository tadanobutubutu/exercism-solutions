package SpiralMatrix;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<spiral_matrix>;

sub spiral_matrix ($size) {
    return [] if $size == 0;
    my @m;
    $m[$_][$_] = 0 for 0 .. $size - 1;
    my ($r, $c) = (0, 0);
    my ($dr, $dc) = (0, 1);
    for my $n (1 .. $size * $size) {
        $m[$r][$c] = $n;
        my ($nr, $nc) = ($r + $dr, $c + $dc);
        if ($nr < 0 || $nr >= $size || $nc < 0 || $nc >= $size || $m[$nr][$nc]) {
            ($dr, $dc) = ($dc, -$dr);
            ($nr, $nc) = ($r + $dr, $c + $dc);
        }
        ($r, $c) = ($nr, $nc);
    }
    [ map { [ $_->@* ] } @m ];
}

1;
