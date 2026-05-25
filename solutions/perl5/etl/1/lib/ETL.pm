package ETL;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<transform>;

sub transform ($data) {
    my %result;
    while (my ($score, $letters) = each %$data) {
        for my $letter (@$letters) {
            $result{lc $letter} = $score;
        }
    }
    return \%result;
}

1;
