package Isogram;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<is_isogram>;

sub is_isogram ($phrase) {
    my %seen;
    for my $c (split //, lc $phrase) {
        next if $c =~ /[^a-z]/;
        return !1 if $seen{$c}++;
    }
    return !0;
}

1;
