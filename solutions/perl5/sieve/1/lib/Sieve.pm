package Sieve;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<find_primes>;

sub find_primes ($limit) {
    return [] if $limit < 2;
    my @primes;
    my @is_prime = (1) x ($limit + 1);
    $is_prime[0] = $is_prime[1] = 0;
    for my $i (2 .. int sqrt $limit) {
        next if !$is_prime[$i];
        for (my $j = $i * $i; $j <= $limit; $j += $i) {
            $is_prime[$j] = 0;
        }
    }
    for my $i (2 .. $limit) {
        push @primes, $i if $is_prime[$i];
    }
    return \@primes;
}

1;
