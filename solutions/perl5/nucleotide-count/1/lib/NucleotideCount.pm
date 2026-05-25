package NucleotideCount;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<count_nucleotides>;

use Carp qw<croak>;

sub count_nucleotides ($strand) {
    my %count = (A => 0, C => 0, G => 0, T => 0);
    for my $n (split //, $strand) {
        croak "Invalid nucleotide in strand" if !exists $count{$n};
        $count{$n}++;
    }
    return \%count;
}

1;
