package Raindrops;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<raindrop>;

sub raindrop ($number) {
    my $sound = "";
    $sound .= "Pling" if $number % 3 == 0;
    $sound .= "Plang" if $number % 5 == 0;
    $sound .= "Plong" if $number % 7 == 0;
    return $sound eq "" ? "$number" : $sound;
}

1;
