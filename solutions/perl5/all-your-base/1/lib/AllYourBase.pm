package AllYourBase;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<rebase>;

my @errors = (
    'input base must be >= 2',
    'output base must be >= 2',
    'all digits must satisfy 0 <= d < input base',
);

use Carp qw<croak>;

sub rebase ( $digits, $input_base, $output_base ) {
    croak $errors[0] if $input_base < 2;
    croak $errors[1] if $output_base < 2;
    croak $errors[2] if grep { $_ < 0 || $_ >= $input_base } @$digits;

    return [0] if @$digits == 0 || $digits->[0] == 0 && @$digits == 1;

    my $value = 0;
    $value = $value * $input_base + $_ for @$digits;

    return [0] if $value == 0;

    my @result;
    while ($value > 0) {
        unshift @result, $value % $output_base;
        $value = int($value / $output_base);
    }
    return \@result;
}

1;
