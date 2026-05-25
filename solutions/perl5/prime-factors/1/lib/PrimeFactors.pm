package PrimeFactors;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<factors>;

sub factors ($number) {
    my @factors;
    while ($number % 2 == 0) {
        push @factors, 2;
        $number /= 2;
    }
    for (my $i = 3; $i * $i <= $number; $i += 2) {
        while ($number % $i == 0) {
            push @factors, $i;
            $number /= $i;
        }
    }
    push @factors, $number if $number > 1;
    return \@factors;
}

1;
