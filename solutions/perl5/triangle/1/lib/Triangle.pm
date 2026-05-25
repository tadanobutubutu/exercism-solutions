package Triangle;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<is_equilateral is_isosceles is_scalene>;

sub _is_valid ($t) {
    my ($a, $b, $c) = @$t;
    return $a > 0 && $b > 0 && $c > 0
        && $a + $b > $c && $a + $c > $b && $b + $c > $a;
}

sub is_equilateral ($triangle) {
    return !1 if !_is_valid($triangle);
    my ($a, $b, $c) = @$triangle;
    return !0 if $a == $b && $b == $c;
    return !1;
}

sub is_isosceles ($triangle) {
    return !1 if !_is_valid($triangle);
    my ($a, $b, $c) = @$triangle;
    return !0 if $a == $b || $b == $c || $a == $c;
    return !1;
}

sub is_scalene ($triangle) {
    return !1 if !_is_valid($triangle);
    my ($a, $b, $c) = @$triangle;
    return !0 if $a != $b && $b != $c && $a != $c;
    return !1;
}

1;
