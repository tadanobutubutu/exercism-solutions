package SumOfMultiples;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<sum_of_multiples>;

sub sum_of_multiples ( $factors, $limit ) {
    my $sum = 0;
    for my $n (1 .. $limit - 1) {
        for my $f (@$factors) {
            next if $f == 0;
            if ($n % $f == 0) {
                $sum += $n;
                last;
            }
        }
    }
    return $sum;
}

1;
