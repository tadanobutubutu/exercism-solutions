package PascalsTriangle;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<pascal_rows>;

sub pascal_rows ($rows) {
    return "" if $rows == 0;
    my $result = "";
    my @row = ();
    for my $r (1 .. $rows) {
        unshift @row, 1;
        for my $i (1 .. $#row - 1) {
            $row[$i] += $row[$i + 1];
        }
        $result .= join(" ", @row);
        $result .= "\n" if $r < $rows;
    }
    return $result;
}

1;
