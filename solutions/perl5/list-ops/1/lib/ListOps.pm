package ListOps;

use v5.40;

sub append ( $list1, $list2 ) {
    [ $list1->@*, $list2->@* ];
}

sub concat ($lists) {
    my @out;
    push @out, $_->@* for $lists->@*;
    \@out;
}

sub filter ( $func, $list ) {
    my @out;
    push @out, $_ for grep { $func->($_) } $list->@*;
    \@out;
}

sub length ($list) {
    scalar $list->@*;
}

sub map ( $func, $list ) {
    my @out;
    push @out, $func->($_) for $list->@*;
    \@out;
}

sub foldl ( $func, $initial, $list ) {
    my $acc = $initial;
    $acc = $func->($acc, $_) for $list->@*;
    $acc;
}

sub foldr ( $func, $initial, $list ) {
    my $acc = $initial;
    $acc = $func->($acc, $_) for reverse $list->@*;
    $acc;
}

sub reverse ($list) {
    my @out;
    push @out, $list->[$_] for CORE::reverse 0 .. $#$list;
    \@out;
}

sub foldr ( $func, $initial, $list ) {
    my $acc = $initial;
    $acc = $func->($acc, $_) for CORE::reverse $list->@*;
    $acc;
}

1;
