package ArmstrongNumbers;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<is_armstrong_number>;

use Math::BigInt;

sub is_armstrong_number ($number) {
    my $str = "$number";
    my $digits = length $str;
    my $sum = Math::BigInt->new(0);
    for my $d (split //, $str) {
        $sum += Math::BigInt->new($d) ** $digits;
    }
    return !0 if $sum == $number;
    return !1;
}

1;
