package WordCount;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<count_words>;

sub count_words ($sentence) {
    my %count;
    while ($sentence =~ /([a-zA-Z0-9]+(?:'[a-zA-Z0-9]+)*)/g) {
        my $word = lc $1;
        $word =~ s/^'+|'+$//g;
        $count{$word}++ if $word ne "";
    }
    return \%count;
}

1;
