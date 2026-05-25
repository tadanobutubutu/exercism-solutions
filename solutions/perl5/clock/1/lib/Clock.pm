use v5.40;
use experimental qw<class>;

class Clock;

field $hour :reader :param;
field $minute :reader :param;

method time () {
    my $total = $hour * 60 + $minute;
    $total %= 1440;
    $total += 1440 if $total < 0;
    sprintf "%02d:%02d", int($total / 60), $total % 60;
}

method add_minutes ($amount) {
    $minute += $amount;
    $self;
}

method subtract_minutes ($amount) {
    $minute -= $amount;
    $self;
}

1;
