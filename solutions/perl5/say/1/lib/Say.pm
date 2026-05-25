package Say;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<say_number>;

sub say_number ($number) {
    die 'input out of range' if $number < 0 || $number > 999_999_999_999;
    return 'zero' if $number == 0;

    my @ones  = qw<zero one two three four five six seven eight nine>;
    my @teens = qw<ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen>;
    my @tens  = qw<zero ten twenty thirty forty fifty sixty seventy eighty ninety>;

    my sub _under_1000 ($n) {
        my @p;
        if ($n >= 100) {
            push @p, $ones[int($n/100)] . ' hundred';
            $n %= 100;
        }
        if ($n >= 20) {
            my $t = $tens[int($n/10)];
            $n %= 10;
            push @p, $n ? "$t-$ones[$n]" : $t;
            return join ' ', @p;
        }
        if ($n >= 10) {
            push @p, $teens[$n - 10];
            $n = 0;
        }
        push @p, $ones[$n] if $n;
        join ' ', @p;
    }

    my $tmp = $number;
    my @groups;
    my @scales = ('', 'thousand', 'million', 'billion');
    for my $i (0 .. $#scales) {
        my $part = $tmp % 1000;
        if ($part) {
            my $text = _under_1000($part);
            $text .= ' ' . $scales[$i] if $scales[$i];
            unshift @groups, $text;
        }
        $tmp = int($tmp / 1000);
    }
    join ' ', @groups;
}

1;
