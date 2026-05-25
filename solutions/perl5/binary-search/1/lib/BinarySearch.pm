package BinarySearch;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<binary_search>;

use Carp qw<croak>;

sub binary_search ( $array, $value ) {
    my $low = 0;
    my $high = $#$array;
    while ($low <= $high) {
        my $mid = int(($low + $high) / 2);
        return $mid if $array->[$mid] == $value;
        if ($array->[$mid] < $value) {
            $low = $mid + 1;
        } else {
            $high = $mid - 1;
        }
    }
    croak "value not in array";
}

1;
