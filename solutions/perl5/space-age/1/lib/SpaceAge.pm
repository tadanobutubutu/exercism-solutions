package SpaceAge;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<age_on_planet>;

use Carp qw<croak>;

sub age_on_planet ( $planet, $seconds ) {
    my %orbital = (
        Mercury => 0.2408467,
        Venus   => 0.61519726,
        Earth   => 1.0,
        Mars    => 1.8808158,
        Jupiter => 11.862615,
        Saturn  => 29.447498,
        Uranus  => 84.016846,
        Neptune => 164.79132,
    );
    croak "not a planet" if !exists $orbital{$planet};
    my $earth_years = $seconds / 31557600;
    return sprintf "%.2f", $earth_years / $orbital{$planet};
}

1;
