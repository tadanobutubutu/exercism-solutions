package Gigasecond;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<add_gigasecond>;

use Time::Piece;

sub add_gigasecond ($time) {
    my $format = $time =~ /T/ ? "%Y-%m-%dT%H:%M:%S" : "%Y-%m-%d";
    my $t = Time::Piece->strptime($time, $format);
    $t += 1000000000;
    return $t->strftime("%Y-%m-%dT%H:%M:%S");
}

1;
