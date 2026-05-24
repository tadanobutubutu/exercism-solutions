package ReverseString;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<str_reverse>;

sub str_reverse ($text) {
    my @chars = $text =~ /\X/g;
    return join("", reverse @chars);
}

1;
