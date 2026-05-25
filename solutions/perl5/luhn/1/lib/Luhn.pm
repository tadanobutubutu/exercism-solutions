package Luhn;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<is_luhn_valid>;

sub is_luhn_valid ($number) {
    $number =~ s/\s//g;
    return !1 if $number =~ /\D/;
    return !1 if length $number < 2;
    my @digits = split //, $number;
    my $sum = 0;
    for my $i (0 .. $#digits) {
        my $d = $digits[$#digits - $i];
        if ($i % 2 == 1) {
            $d *= 2;
            $d -= 9 if $d > 9;
        }
        $sum += $d;
    }
    return !0 if $sum % 10 == 0;
    return !1;
}

1;
