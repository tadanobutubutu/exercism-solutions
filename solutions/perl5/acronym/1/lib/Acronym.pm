package Acronym;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<abbreviate>;

sub abbreviate ($phrase) {
    my @letters = $phrase =~ /(?<![a-zA-Z'])([a-zA-Z])/g;
    return uc join("", @letters);
}

1;
