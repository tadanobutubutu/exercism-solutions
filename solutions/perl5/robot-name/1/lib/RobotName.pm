package RobotName;
use strict;
use warnings;

my $counter = 0;

sub _name_from_counter {
    my $n = $counter++;
    my $l1 = chr(65 + $n % 26);
    my $l2 = chr(65 + int($n / 26) % 26);
    my $num = $n % 1000;
    sprintf "%s%s%03d", $l1, $l2, $num;
}

sub new {
    my $class = shift;
    my $self = { name => _name_from_counter() };
    bless $self, $class;
}

sub name {
    my $self = shift;
    $self->{name};
}

sub reset_name {
    my $self = shift;
    $self->{name} = _name_from_counter();
}

1;
