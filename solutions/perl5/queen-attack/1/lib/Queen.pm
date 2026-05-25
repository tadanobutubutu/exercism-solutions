package Queen;
use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    die "row not on board" if $args{row} < 0 || $args{row} > 7;
    die "column not on board" if $args{column} < 0 || $args{column} > 7;
    bless \%args, $class;
}

sub can_attack {
    my ($self, $other) = @_;
    return 1 if $self->{row} == $other->{row};
    return 1 if $self->{column} == $other->{column};
    return 1 if abs($self->{row} - $other->{row}) == abs($self->{column} - $other->{column});
    0;
}

1;
