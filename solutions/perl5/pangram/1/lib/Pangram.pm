package Pangram;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<is_pangram>;

sub is_pangram ($text) {
    my %seen;
    $seen{$_}++ for grep { /[a-z]/ } split //, lc $text;
    return scalar(keys %seen) == 26;
}

1;
