package RomanNumerals;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<to_roman>;

sub to_roman ($number) {
    my @pairs = (
        [1000, "M"], [900, "CM"], [500, "D"], [400, "CD"],
        [100, "C"], [90, "XC"], [50, "L"], [40, "XL"],
        [10, "X"], [9, "IX"], [5, "V"], [4, "IV"], [1, "I"],
    );
    my $result = "";
    for my $pair (@pairs) {
        my ($val, $sym) = @$pair;
        while ($number >= $val) {
            $result .= $sym;
            $number -= $val;
        }
    }
    return $result;
}

1;
