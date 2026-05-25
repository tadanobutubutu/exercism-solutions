package RNA;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<to_rna>;

sub to_rna ($dna) {
    my %map = (C => 'G', G => 'C', T => 'A', A => 'U');
    join '', map { $map{$_} } split //, $dna;
}

1;
