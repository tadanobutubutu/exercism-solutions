package PhoneNumber;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<clean_number>;

my @errors = (
    '11 digits must start with 1',
    'must not be greater than 11 digits',
    'must not be fewer than 10 digits',
    'letters not permitted',
    'punctuations not permitted',
    'area code cannot start with zero',
    'area code cannot start with one',
    'exchange code cannot start with zero',
    'exchange code cannot start with one',
);

sub clean_number ($number) {
    die 'letters not permitted' if $number =~ /[a-zA-Z]/;
    die 'punctuations not permitted' if $number =~ /[@:!]/;
    my $digits = $number =~ tr/0-9//;
    die 'must not be fewer than 10 digits' if $digits < 10;
    die 'must not be greater than 11 digits' if $digits > 11;
    $number =~ s/\D//g;
    if (length($number) == 11) {
        die '11 digits must start with 1' if substr($number, 0, 1) ne '1';
        $number = substr($number, 1);
    }
    die 'area code cannot start with zero' if substr($number, 0, 1) eq '0';
    die 'area code cannot start with one' if substr($number, 0, 1) eq '1';
    die 'exchange code cannot start with zero' if substr($number, 3, 1) eq '0';
    die 'exchange code cannot start with one' if substr($number, 3, 1) eq '1';
    $number;
}

1;
