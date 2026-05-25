package TwelveDays;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<recite>;

my @days  = qw<first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth>;
my @gifts = (
    'a Partridge in a Pear Tree',
    'two Turtle Doves',
    'three French Hens',
    'four Calling Birds',
    'five Gold Rings',
    'six Geese-a-Laying',
    'seven Swans-a-Swimming',
    'eight Maids-a-Milking',
    'nine Ladies Dancing',
    'ten Lords-a-Leaping',
    'eleven Pipers Piping',
    'twelve Drummers Drumming',
);

sub recite ( $start, $end ) {
    join "\n", map {
        my $day = $_;
        my $verse = "On the $days[$day-1] day of Christmas my true love gave to me: ";
        $verse .= join ', ', reverse @gifts[1 .. $day-1];
        $verse .= ', and ' if $day > 1;
        $verse .= $gifts[0] . '.';
        $verse;
    } $start .. $end;
}

1;
