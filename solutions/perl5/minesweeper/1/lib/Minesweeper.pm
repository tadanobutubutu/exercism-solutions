package Minesweeper;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<annotate>;

sub annotate ($minefield) {
    return $minefield if $minefield eq '';
    my @rows = split "\n", $minefield;
    return $minefield if @rows == 0 || length($rows[0]) == 0;
    my @out;
    for my $r (0 .. $#rows) {
        my @cols = split '', $rows[$r];
        for my $c (0 .. $#cols) {
            next if $cols[$c] eq '*';
            my $count = 0;
            for my $dr (-1 .. 1) {
                for my $dc (-1 .. 1) {
                    next if $dr == 0 && $dc == 0;
                    my $nr = $r + $dr;
                    my $nc = $c + $dc;
                    next if $nr < 0 || $nr > $#rows;
                    next if $nc < 0 || $nc > $#cols;
                    $count++ if substr($rows[$nr], $nc, 1) eq '*';
                }
            }
            $cols[$c] = $count if $count;
        }
        push @out, join '', @cols;
    }
    join "\n", @out;
}

1;
