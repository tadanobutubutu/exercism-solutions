package Grains;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<grains_on_square total_grains>;

use Carp qw<croak>;
use bigint;

sub grains_on_square ($square) {
    croak "square must be between 1 and 64" if $square < 1 || $square > 64;
    return 2 ** ($square - 1);
}

sub total_grains () {
    return 2 ** 64 - 1;
}

1;
