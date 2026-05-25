package Anagram;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<match_anagrams>;

sub match_anagrams ( $subject, $candidates ) {
    my $key = join '', sort split //, lc $subject;
    my $lc_subj = lc $subject;
    [ grep { lc($_) ne $lc_subj && (join('', sort split //, lc $_)) eq $key } $candidates->@* ];
}

1;
