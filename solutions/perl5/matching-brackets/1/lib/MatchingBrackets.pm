package MatchingBrackets;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<has_matching_brackets>;

sub has_matching_brackets ($text) {
    my %pairs = ('[' => ']', '{' => '}', '(' => ')');
    my %close; @close{values %pairs} = keys %pairs;
    my @stack;
    for my $ch (split //, $text) {
        if (exists $pairs{$ch}) {
            push @stack, $ch;
        } elsif (exists $close{$ch}) {
            return !1 unless @stack && (pop @stack) eq $close{$ch};
        }
    }
    @stack ? !1 : !0;
}

1;
