package Proverb;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<proverb>;

sub proverb ($items) {
    return "" if $items->@* == 0;
    my @lines;
    push @lines, "For want of a $items->[$_] the $items->[$_+1] was lost." for 0 .. $#$items - 1;
    push @lines, "And all for the want of a $items->[0].";
    join "\n", @lines;
}

1;
