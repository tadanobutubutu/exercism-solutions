package CollatzConjecture;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<steps>;

use Carp qw<croak>;

sub steps ($number) {
    croak "Only positive integers are allowed" if $number < 1;
    my $count = 0;
    while ($number > 1) {
        $number = $number % 2 == 0 ? $number / 2 : 3 * $number + 1;
        $count++;
    }
    return $count;
}

1;
